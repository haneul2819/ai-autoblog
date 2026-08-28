# AI 자동 블로그

PC가 켜져 있는 동안 로컬에서 돌면서, 하루 세 번 AI 분야의 새 주제를 하나씩 골라
한국어 글을 쓰고 사이트에 배포하는 장치입니다.

글을 쓰는 주체는 **로그인된 Claude Code 구독 세션**입니다. `ANTHROPIC_API_KEY`는
쓰지 않습니다. 생성 스크립트가 환경에서 키를 걷어내고 헤드리스 모드로 세션을 띄웁니다.

```
09:00 / 14:00 / 20:00
   ↓
run-scheduled.ps1   오늘 몇 편 나왔는지 세고, 부족분만큼만 돌린다
   ↓
generate-post.sh    최근 글 목록 + 집필 규칙을 프롬프트로 조립
   ↓
claude -p           WebSearch로 최근 3일 조사 → 주제 선정 → 집필 → 파일 저장
   ↓
검사 → git commit & push → Vercel 빌드
```

---

## 1. 구조

```
자동블로그/
├─ config.json              모드·하루 편수·마감 시각·사이트 정보·주제 범위
├─ prompts/
│  └─ write-post.md         집필 규칙. 글의 성격을 바꾸려면 여기를 고칩니다
├─ scripts/
│  ├─ generate-post.sh      글 한 편 생성 (핵심)
│  ├─ recent-posts.mjs      최근 글의 제목·태그를 뽑아 프롬프트에 넣는다
│  ├─ validate-post.mjs     생성된 글 검사 (분량·출처·이모지·front matter)
│  ├─ run-scheduled.ps1     예약 실행기. 놓친 회차 보충과 재시도를 담당
│  └─ register-task.ps1     작업 스케줄러 등록·해제
├─ content/
│  ├─ posts/                발행된 글. 이 폴더의 .md 가 곧 사이트의 글입니다
│  ├─ drafts/               검토 모드에서 쓴 글. 사이트에 노출되지 않습니다
│  └─ rejected/             검사에 걸린 글. 빌드를 깨뜨리지 않게 여기로 치웁니다
├─ logs/
│  ├─ YYYY-MM.log           월별 실행 기록
│  └─ raw/                  헤드리스 세션의 원본 응답 (git에 올리지 않음)
└─ src/                     Astro 사이트
```

---

## 2. 설치

필요한 것: Node.js 20+, Git for Windows, 로그인된 Claude Code.

```bash
npm install
```

Claude Code 로그인 상태는 이렇게 확인합니다. 로그인이 안 돼 있으면 먼저 `claude` 를
한 번 실행해 로그인하세요.

```bash
claude -p "ok 라고만 답해" --output-format json
```

사이트 주소와 제목을 `config.json`의 `site` 항목에서 바꿉니다. RSS와 sitemap의
절대 주소로 쓰이므로 Vercel 배포 주소가 정해지면 반드시 고쳐 주세요.

---

## 3. 손으로 한 편 만들어 보기

```bash
bash scripts/generate-post.sh
```

3~10분 걸립니다. 진행 상황은 화면에, 결과 한 줄은 `logs/2026-08.log` 에 남습니다.
`config.json`의 `mode`가 기본값 `draft`이므로 결과물은 `content/drafts/` 에 저장되고
사이트에는 나타나지 않습니다.

만들어진 글을 사이트에서 확인합니다. 초안까지 함께 띄우는 미리보기 모드입니다.
화면 맨 위에 초안 미리보기라는 띠가 뜨고, 이 모드는 배포 빌드와 무관합니다.

```bash
npm run dev:drafts
```

발행된 글만 보려면 `npm run dev` 입니다.

읽어 보고 발행하기로 했다면 파일을 옮기기만 하면 됩니다. 주소는 파일 이름으로 정해지므로
폴더를 옮겨도 주소가 바뀌지 않습니다.

```bash
mv content/drafts/2026-08-29-어떤-글.md content/posts/
```

---

## 4. 스케줄러 등록

며칠 치 결과를 보고 마음에 들면 등록합니다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1
```

시각을 바꾸려면:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1 -Times 08:00,13:00,19:00
```

해제:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1 -Unregister
```

등록 확인과 즉시 실행:

```powershell
Get-ScheduledTask -TaskName 'AI-AutoBlog' | Get-ScheduledTaskInfo
Start-ScheduledTask -TaskName 'AI-AutoBlog'
```

관리자 권한은 필요 없습니다. 로그인한 사용자 계정으로만 도는 작업이라 PC가 켜져 있고
로그인돼 있을 때만 실행됩니다.

### 놓친 회차는 어떻게 되나

실행될 때마다 `run-scheduled.ps1`이 **오늘 날짜로 만들어진 글 수**를 셉니다
(`content/posts` 와 `content/drafts` 를 함께 봅니다). 하루 목표 3편에 모자라면
모자란 만큼 **연속으로** 만듭니다.

- 오전에 PC가 꺼져 있어 09:00 회차를 놓쳤다면, 14:00 실행이 2편을 씁니다.
- 하루 종일 꺼져 있다가 20:00에 켰다면 그 실행이 3편을 씁니다.
- **22시를 넘기면 그날 분은 포기합니다.** 다음 날로 넘겨 몰아쓰지 않습니다.
  생성 도중에 22시를 넘겨도 남은 편수를 접습니다.

마감 시각은 `config.json`의 `cutoffHour`, 하루 편수는 `postsPerDay`로 조정합니다.

### 실패하면

한 편이 실패하면 5분 뒤 **한 번만** 다시 시도합니다. 재시도도 실패하면 로그에 남기고
그 실행을 끝냅니다. 같은 회차를 무한히 붙들지 않습니다.

---

## 5. 검토 모드에서 발행 모드로

`config.json`:

```json
{ "mode": "draft" }
```

| 값 | 저장 위치 | 사이트 노출 |
|---|---|---|
| `draft` (기본) | `content/drafts/` | 안 됨 |
| `publish` | `content/posts/` | 됨 |

며칠 결과를 보고 직접 `"publish"` 로 바꾸세요. 바꾸기 전에 쌓인 초안 중 쓸 만한 것은
`content/drafts/` 에서 `content/posts/` 로 옮기면 그대로 발행됩니다.

초안은 검토 모드에서도 "이미 다룬 주제" 목록에 들어갑니다. 초안으로만 쓴 주제를
나중에 다시 쓰는 일은 없습니다.

개별 글을 임시로 감추고 싶으면 front matter에 `draft: true` 를 넣으면 됩니다.

| 명령 | 하는 일 |
|---|---|
| `npm run dev` | 발행된 글만 띄운다 (배포본과 같은 상태) |
| `npm run dev:drafts` | 초안까지 함께 띄운다 (검토용) |
| `npm run build` | 배포용 빌드 |
| `npm run check` | 타입 검사 |
| `npm run post` | 글 한 편 생성 (`bash scripts/generate-post.sh` 와 같음) |

---

## 6. 주제 방향 바꾸기

세 군데를 만집니다.

**`config.json`의 `topicScope`** — 한 줄로 범위와 제외 대상을 적습니다. 프롬프트에
그대로 들어갑니다.

```json
"topicScope": "AI 연구 논문, 모델과 제품 발표, 개발자 도구. 홍보성 보도자료와 주가 전망은 제외한다."
```

**`prompts/write-post.md`** — 글의 성격 전반을 정합니다. 분량, 네 덩어리 구조, 문체,
사실 확인 규칙이 모두 여기 있습니다. "주제 선정" 절의 기준 네 가지와 "주제 범위" 절을
고치면 무엇을 쓸지가 바뀌고, "집필" 절을 고치면 어떻게 쓸지가 바뀝니다.

**`config.json`의 `recentTopicWindow`** — 중복을 피하기 위해 참조하는 최근 글 편수
(기본 60). 늘리면 더 멀리까지 안 겹치게 하고, 줄이면 같은 주제로 다시 돌아오는 주기가
짧아집니다.

검사 기준(분량 하한, 이모지 금지 등)은 `scripts/validate-post.mjs` 에 있습니다.

---

## 7. 로그 읽기

`logs/2026-08.log`:

```
2026-08-29 09:00:02 | RUN | 시작 — 오늘 0/3편, 이번에 3편 보충 (모드 draft)
2026-08-29 09:00:02 | RUN | 1/3번째 생성 시도
2026-08-29 09:04:38 | OK | 276s | draft | 2026-08-29-example-slug.md | 글 제목
2026-08-29 09:09:11 | FAIL | 271s | draft | - | 새 글 파일이 생기지 않았다...
2026-08-29 09:09:11 | RETRY | 실패. 5분 뒤 한 번만 다시 시도한다.
2026-08-29 09:20:44 | SKIP | 마감 22시가 지나 오늘 분은 접는다 (오늘 2/3편)
```

| 태그 | 뜻 |
|---|---|
| `RUN` | 실행 시작·종료, 몇 편을 시도하는지 |
| `OK` | 한 편 성공. 소요시간·모드·파일명·제목 |
| `FAIL` | 한 편 실패. 이유 |
| `SKIP` | 목표를 이미 채웠거나 마감 시각을 넘겼거나, 세션이 쓸 주제를 못 찾음 |
| `RETRY` / `ABORT` | 재시도 / 재시도 실패 후 종료 |

실패를 파헤칠 때는 `logs/raw/` 의 같은 시각 `.json`(세션 응답 전문)과 `.err`(표준 오류)를
봅니다. 이 폴더는 `.gitignore` 대상입니다.

---

## 8. GitHub와 Vercel 연결

로컬 저장소는 이미 만들어져 있습니다. GitHub 원격만 붙이면 됩니다.

```bash
gh repo create ai-autoblog --private --source=. --remote=origin --push
```

이미 만들어 둔 저장소가 있다면:

```bash
git remote add origin https://github.com/<계정>/<저장소>.git
git push -u origin main
```

원격이 붙기 전까지 생성 스크립트는 커밋만 하고 푸시는 건너뜁니다. 로그에
`origin 원격 없음 — 푸시 생략` 으로 남습니다.

Vercel 쪽 설정:

1. [vercel.com/new](https://vercel.com/new) 에서 저장소를 가져옵니다.
2. 프레임워크는 **Astro** 로 자동 인식됩니다. 빌드 명령 `npm run build`,
   출력 디렉터리 `dist`.
3. 배포 주소가 나오면 `config.json` 의 `site.url` 을 그 주소로 고치고 커밋합니다.
   (RSS와 sitemap이 절대 주소를 쓰기 때문에 이 단계를 빠뜨리면 링크가 틀어집니다.)

이후로는 생성 스크립트가 푸시할 때마다 Vercel이 알아서 다시 빌드합니다.

---

## 9. 사이트에 대해

- 목록은 12편씩 나뉩니다. `/`, `/2`, `/3` …
- 글 주소는 `/posts/2026-08-29-slug/` 입니다.
- 태그 목록 `/tags/`, 태그별 목록 `/tags/<태그>/`
- `/rss.xml`, `/sitemap.xml`
- 다크모드 토글은 헤더 오른쪽에 있고, 선택은 브라우저에 저장됩니다. 선택하지 않으면
  OS 설정을 따릅니다.
- 본문은 한 줄 35~40자, 줄간격 1.9, 한글 어절 단위 줄바꿈(`word-break: keep-all`)으로
  잡았습니다. 폰트는 외부에서 받아 오지 않고 시스템 폰트를 씁니다.

---

## 10. 문제 해결

**`claude 실행 파일을 찾지 못했다`**
`CLAUDE_BIN` 환경 변수에 경로를 직접 넣거나, `npm i -g @anthropic-ai/claude-code` 로
다시 설치합니다.

**작업 스케줄러가 도는데 글이 안 나온다**
로그인 세션이 살아 있어야 합니다(잠금 화면은 괜찮지만 로그아웃 상태는 안 됩니다).
`logs/raw/*.err` 를 먼저 확인하세요. 구독 사용량 한도에 걸렸다면 그 내용이 찍힙니다.

**로그의 한글이 깨진다**
`.ps1` 파일은 **BOM이 붙은 UTF-8**로 저장해야 합니다. Windows PowerShell 5.1은 BOM이
없으면 스크립트를 시스템 ANSI 코드페이지(한국어 환경에서 CP949)로 읽어 한글 문자열을
망가뜨립니다. 편집기에서 "UTF-8 with BOM"으로 저장하세요. 메모장은 그냥 "UTF-8"이
BOM 포함입니다.

**`Git Bash(bash.exe)를 찾지 못했다`**
Git for Windows를 설치하거나, 설치 경로가 특이하면 `run-scheduled.ps1` 의
`Resolve-GitBash` 후보 목록에 경로를 추가합니다.

**같은 주제가 반복된다**
`recentTopicWindow` 를 늘리고, `prompts/write-post.md` 의 "주제 선정" 기준을
더 좁게 적습니다.

**글이 `content/rejected/` 로 갔다**
검사에 걸렸다는 뜻입니다. 콘솔이나 로그에 어떤 항목이 걸렸는지 나옵니다. 대개는
분량 미달이나 출처 누락입니다. 손으로 고쳐 `content/posts/` 로 옮겨도 됩니다.
