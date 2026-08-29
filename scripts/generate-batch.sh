#!/usr/bin/env bash
#
# AI 자동 블로그 — 여러 편 잇달아 생성
#
#   bash scripts/generate-batch.sh 10
#
# 밀린 분량을 한 번에 채우거나 사이트를 처음 채울 때 쓴다.
# 반드시 순차로 돈다. 동시에 돌리면 두 세션이 같은 "최근 글 목록"을 읽어
# 같은 주제를 골라 버린다.
#
# 멈추는 조건
#   - 목표 편수를 채웠을 때
#   - 연속 2회 실패 (사용량 한도 같은 문제로 계속 태우지 않는다)
#   - 연속 3회 건너뜀 (더 쓸 주제가 없다는 뜻)

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TARGET="${1:-10}"
LOG_FILE="logs/$(date +%Y-%m).log"

if ! [[ "$TARGET" =~ ^[0-9]+$ ]] || [ "$TARGET" -lt 1 ]; then
  echo "사용법: bash scripts/generate-batch.sh <편수>" >&2
  exit 2
fi

log_line() {
  printf '%s | %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"
}

made=0
skipped=0
failed=0
fail_streak=0
skip_streak=0
attempt=0
started=$SECONDS

log_line "BATCH | 시작 — ${TARGET}편 목표"
echo "── 연속 생성 ${TARGET}편 ────────────────────────────────"
echo ""

while [ "$made" -lt "$TARGET" ]; do
  attempt=$((attempt + 1))
  echo "[$((made + 1))/${TARGET}] 생성 중... (누적 시도 ${attempt}회)"

  output="$(bash scripts/generate-post.sh 2>&1)"
  status=$?

  # generate-post.sh 는 사람이 읽을 진행 상황을 stderr, 결과를 stdout 에 낸다.
  result="$(printf '%s\n' "$output" | grep -m1 '^RESULT=' | cut -d= -f2)"
  title="$(printf '%s\n' "$output" | grep -m1 '^TITLE=' | cut -d= -f2-)"

  case "$result" in
    ok)
      made=$((made + 1))
      fail_streak=0
      skip_streak=0
      echo "    완료: ${title}"
      ;;
    skip)
      skipped=$((skipped + 1))
      skip_streak=$((skip_streak + 1))
      fail_streak=0
      echo "    건너뜀 (연속 ${skip_streak}회)"
      if [ "$skip_streak" -ge 3 ]; then
        echo ""
        echo "쓸 만한 새 주제를 세 번 연속 찾지 못했다. 여기서 멈춘다."
        log_line "BATCH | 중단 — 연속 3회 주제 없음"
        break
      fi
      ;;
    *)
      failed=$((failed + 1))
      fail_streak=$((fail_streak + 1))
      echo "    실패 (연속 ${fail_streak}회, 종료 코드 ${status})"
      printf '%s\n' "$output" | tail -n 3 | sed 's/^/      /'
      if [ "$fail_streak" -ge 2 ]; then
        echo ""
        echo "연속 두 번 실패했다. 여기서 멈춘다. logs/raw/ 를 확인하라."
        log_line "BATCH | 중단 — 연속 2회 실패"
        break
      fi
      echo "    30초 뒤 다시 시도한다."
      sleep 30
      ;;
  esac

  echo ""
done

elapsed=$((SECONDS - started))
log_line "BATCH | 종료 — 성공 ${made} / 건너뜀 ${skipped} / 실패 ${failed} / ${elapsed}s"

echo "── 결과 ────────────────────────────────────────────────"
echo "  생성   ${made}편"
echo "  건너뜀 ${skipped}회"
echo "  실패   ${failed}회"
echo "  소요   $((elapsed / 60))분 $((elapsed % 60))초"

printf 'BATCH_MADE=%s\nBATCH_SKIPPED=%s\nBATCH_FAILED=%s\n' "$made" "$skipped" "$failed"

[ "$made" -gt 0 ] || exit 1
