#!/usr/bin/env bash
#
# AI 자동 블로그 — 글 한 편 생성
#
#   scripts/generate-post.sh
#
# 하는 일
#   1) content/posts 와 content/drafts 의 front matter에서 최근 N편의 제목·태그·날짜를 읽는다
#   2) 그 목록과 집필 규칙을 합쳐 헤드리스 Claude 세션을 띄운다
#   3) 세션이 WebSearch로 최근 3일치를 조사하고, 겹치지 않는 주제를 골라 글을 쓰고 저장한다
#   4) 저장된 파일을 검사하고 git commit & push 한다
#
# ANTHROPIC_API_KEY는 쓰지 않는다. 로그인된 구독 세션을 그대로 사용한다.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# ── 설정 ──────────────────────────────────────────────────────────────────
read_config() {
  node -e '
    const fs = require("fs");
    const cfg = JSON.parse(fs.readFileSync("config.json", "utf-8"));
    const path = process.argv[1].split(".");
    let value = cfg;
    for (const key of path) value = value?.[key];
    process.stdout.write(value === undefined || value === null ? "" : String(value));
  ' "$1"
}

MODE="$(read_config mode)"
WINDOW="$(read_config recentTopicWindow)"
SCOPE="$(read_config topicScope)"
TIMEOUT_SECONDS="$(read_config timeoutSeconds)"

[ -n "$MODE" ] || MODE="draft"
[ -n "$WINDOW" ] || WINDOW="60"
[ -n "$TIMEOUT_SECONDS" ] || TIMEOUT_SECONDS="1500"

if [ "$MODE" = "publish" ]; then
  TARGET_DIR="content/posts"
  MODE_LABEL="발행 모드 — 저장 즉시 사이트에 노출된다"
else
  MODE="draft"
  TARGET_DIR="content/drafts"
  MODE_LABEL="검토 모드 — 사이트에는 노출되지 않는다"
fi

TODAY="$(date +%Y-%m-%d)"
STAMP="$(date +%Y%m%d-%H%M%S)"
LOG_FILE="logs/$(date +%Y-%m).log"
RAW_DIR="logs/raw"

mkdir -p "$TARGET_DIR" content/posts content/drafts content/rejected logs "$RAW_DIR"

case "$(date +%u)" in
  1) DOW=월 ;; 2) DOW=화 ;; 3) DOW=수 ;; 4) DOW=목 ;;
  5) DOW=금 ;; 6) DOW=토 ;; *) DOW=일 ;;
esac

# ── 로그 ──────────────────────────────────────────────────────────────────
log_line() {
  printf '%s | %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"
}

say() { printf '%s\n' "$1" >&2; }

finish_fail() {
  local reason="$1"
  local elapsed="${SECONDS}"
  log_line "FAIL | ${elapsed}s | ${MODE} | - | ${reason}"
  say ""
  say "실패: ${reason}"
  say "로그: ${LOG_FILE}"
  printf 'RESULT=fail\nREASON=%s\n' "$reason"
  exit 1
}

# ── claude 실행 파일 찾기 ─────────────────────────────────────────────────
CLAUDE_BIN="${CLAUDE_BIN:-}"
if [ -z "$CLAUDE_BIN" ]; then
  if command -v claude >/dev/null 2>&1; then
    CLAUDE_BIN="$(command -v claude)"
  else
    for candidate in \
      "$HOME/AppData/Roaming/npm/claude" \
      "$HOME/.claude/local/claude" \
      "$HOME/.local/bin/claude" \
      "/usr/local/bin/claude"
    do
      if [ -x "$candidate" ]; then CLAUDE_BIN="$candidate"; break; fi
    done
  fi
fi

[ -n "$CLAUDE_BIN" ] || finish_fail "claude 실행 파일을 찾지 못했다. CLAUDE_BIN 환경 변수로 경로를 지정하라."

# 구독 세션으로 붙어야 한다. API 키가 환경에 남아 있으면 걷어낸다.
unset ANTHROPIC_API_KEY ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL || true

say "── AI 자동 블로그 · 글 생성 ────────────────────────────────"
say "  날짜   ${TODAY} (${DOW})"
say "  모드   ${MODE} · ${MODE_LABEL}"
say "  저장   ${TARGET_DIR}/"
say "  실행   ${CLAUDE_BIN}"
say ""

# ── 1. 최근 글 목록 ───────────────────────────────────────────────────────
RECENT="$(node scripts/recent-posts.mjs "$ROOT" "$WINDOW")"
RECENT_COUNT="$(printf '%s\n' "$RECENT" | grep -c '^- ' || true)"
say "최근 글 ${RECENT_COUNT}편을 참조 목록으로 넘긴다."

# ── 2. 프롬프트 조립 ──────────────────────────────────────────────────────
PROMPT_FILE="$(mktemp)"
BEFORE_LIST=""
AFTER_LIST=""
trap 'rm -f "$PROMPT_FILE" "$BEFORE_LIST" "$AFTER_LIST" 2>/dev/null || true' EXIT

{
  cat prompts/write-post.md
  printf '\n\n---\n\n'
  printf '## 이번 회차 정보\n\n'
  printf -- '- 오늘 날짜: %s (%s)\n' "$TODAY" "$DOW"
  printf -- '- 저장 경로: `%s/` — %s\n' "$TARGET_DIR" "$MODE_LABEL"
  printf -- '- 파일명: `%s/%s-<슬러그>.md`\n' "$TARGET_DIR" "$TODAY"
  printf -- '  슬러그는 영문 소문자·숫자·하이픈만 쓰고 40자를 넘기지 않는다.\n'
  printf -- '- front matter의 `date`: `%s`\n' "$TODAY"
  printf -- '- 저장소 루트: `%s`\n' "$ROOT"
  if [ -n "$SCOPE" ]; then
    printf -- '- 이번 저장소의 주제 범위: %s\n' "$SCOPE"
  fi
  printf '\n## 최근 글 목록 (최신순, 최대 %s편)\n\n' "$WINDOW"
  printf '%s\n' "$RECENT"
  printf '\n이 목록과 겹치는 주제는 고르지 않는다.\n'
} > "$PROMPT_FILE"

# ── 3. 실행 전 파일 목록 ──────────────────────────────────────────────────
BEFORE_LIST="$(mktemp)"
AFTER_LIST="$(mktemp)"
find content/posts content/drafts -maxdepth 1 -name '*.md' | sort > "$BEFORE_LIST"

# ── 4. 헤드리스 세션 실행 ─────────────────────────────────────────────────
OUT_JSON="${RAW_DIR}/${STAMP}.json"
ERR_LOG="${RAW_DIR}/${STAMP}.err"

say "Claude 세션 시작 (최대 ${TIMEOUT_SECONDS}초)..."

RUNNER=()
if command -v timeout >/dev/null 2>&1; then
  RUNNER=(timeout --signal=TERM --kill-after=30 "$TIMEOUT_SECONDS")
fi

set +e
"${RUNNER[@]}" "$CLAUDE_BIN" -p "$(cat "$PROMPT_FILE")" \
  --allowedTools "Read,Write,Edit,WebSearch,WebFetch,Bash(git:*)" \
  --permission-mode acceptEdits \
  --output-format json \
  > "$OUT_JSON" 2> "$ERR_LOG"
CLAUDE_STATUS=$?
set -e

if [ "$CLAUDE_STATUS" -eq 124 ]; then
  finish_fail "Claude 세션이 ${TIMEOUT_SECONDS}초 제한을 넘겨 중단됐다."
fi

RESULT_TEXT="$(node -e '
  const fs = require("fs");
  try {
    const data = JSON.parse(fs.readFileSync(process.argv[1], "utf-8"));
    process.stdout.write(String(data.result ?? ""));
  } catch {
    process.stdout.write("");
  }
' "$OUT_JSON")"

if [ "$CLAUDE_STATUS" -ne 0 ]; then
  say "$(tail -n 5 "$ERR_LOG" 2>/dev/null || true)"
  finish_fail "Claude 세션이 종료 코드 ${CLAUDE_STATUS}로 끝났다. 원본: ${ERR_LOG}"
fi

if printf '%s' "$RESULT_TEXT" | grep -q '^SKIP:'; then
  SKIP_REASON="$(printf '%s' "$RESULT_TEXT" | grep '^SKIP:' | head -1 | cut -c7-)"
  log_line "SKIP | ${SECONDS}s | ${MODE} | - |${SKIP_REASON}"
  say ""
  say "이번 회차는 건너뛴다:${SKIP_REASON}"
  printf 'RESULT=skip\n'
  exit 0
fi

# ── 5. 새로 생긴 파일 찾기 ────────────────────────────────────────────────
find content/posts content/drafts -maxdepth 1 -name '*.md' | sort > "$AFTER_LIST"
NEW_FILE="$(comm -13 "$BEFORE_LIST" "$AFTER_LIST" | head -1)"

if [ -z "$NEW_FILE" ]; then
  # 세션이 보고한 경로라도 있으면 그걸 믿어 본다.
  CLAIMED="$(printf '%s' "$RESULT_TEXT" | grep -m1 '^FILE:' | sed 's/^FILE:[[:space:]]*//' | tr -d '\r')"
  if [ -n "$CLAIMED" ] && [ -f "$CLAIMED" ]; then
    NEW_FILE="$CLAIMED"
  else
    say ""
    say "세션 응답 마지막 부분:"
    say "$(printf '%s' "$RESULT_TEXT" | tail -c 600)"
    finish_fail "새 글 파일이 생기지 않았다. 원본 응답: ${OUT_JSON}"
  fi
fi

say ""
say "생성된 파일: ${NEW_FILE}"

# ── 6. 검사 ───────────────────────────────────────────────────────────────
if ! node scripts/validate-post.mjs "$NEW_FILE" >&2; then
  REJECTED="content/rejected/$(basename "$NEW_FILE")"
  mv "$NEW_FILE" "$REJECTED"
  finish_fail "검사 불합격. 사이트를 깨뜨리지 않도록 ${REJECTED} 로 옮겼다."
fi

TITLE="$(grep -m1 '^title:' "$NEW_FILE" | sed -e "s/^title:[[:space:]]*//" -e "s/^[\"']//" -e "s/[\"']$//" | tr -d '\r')"
[ -n "$TITLE" ] || TITLE="$(basename "$NEW_FILE" .md)"

# ── 7. 커밋과 푸시 ────────────────────────────────────────────────────────
PUSH_NOTE=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  git add -- "$NEW_FILE"
  if git diff --cached --quiet -- "$NEW_FILE"; then
    PUSH_NOTE="변경 없음 — 커밋 생략"
  else
    # --only 로 이 글 하나만 담는다. 작업하다 남긴 스테이징이 딸려 들어가지 않도록.
    git commit -q --only -m "post(${MODE}): ${TITLE}" -m "자동 생성: ${NEW_FILE}" -- "$NEW_FILE"
    say "커밋 완료."
    if git remote get-url origin >/dev/null 2>&1; then
      BRANCH="$(git rev-parse --abbrev-ref HEAD)"
      if git push -q origin "$BRANCH" 2>>"$ERR_LOG"; then
        say "origin/${BRANCH} 로 푸시 완료. 배포 워크플로가 시작된다."
      else
        PUSH_NOTE="푸시 실패 — 커밋은 남아 있다"
        say "경고: 푸시에 실패했다. 커밋은 로컬에 남아 있으니 나중에 다시 밀면 된다."
      fi
    else
      PUSH_NOTE="origin 원격 없음 — 푸시 생략"
      say "원격 저장소(origin)가 없어 푸시는 건너뛴다."
    fi
  fi
else
  PUSH_NOTE="git 저장소 아님 — 커밋 생략"
  say "git 저장소가 아니라 커밋을 건너뛴다."
fi

# ── 8. 마무리 ─────────────────────────────────────────────────────────────
ELAPSED="${SECONDS}"
log_line "OK | ${ELAPSED}s | ${MODE} | $(basename "$NEW_FILE") | ${TITLE}${PUSH_NOTE:+ | $PUSH_NOTE}"

say ""
say "완료 — ${ELAPSED}초"
say "  제목  ${TITLE}"
say "  파일  ${NEW_FILE}"
say "  로그  ${LOG_FILE}"

printf 'RESULT=ok\nFILE=%s\nTITLE=%s\nELAPSED=%s\n' "$NEW_FILE" "$TITLE" "$ELAPSED"
