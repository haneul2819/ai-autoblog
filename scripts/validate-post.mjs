// 생성된 글이 규칙을 지켰는지 확인한다.
// 사용법: node scripts/validate-post.mjs <파일경로>
// 종료 코드 0 = 통과(경고는 있을 수 있음), 1 = 불합격.
import { readFileSync } from 'node:fs';

const file = process.argv[2];
if (!file) {
  console.error('사용법: node scripts/validate-post.mjs <파일경로>');
  process.exit(2);
}

const raw = readFileSync(file, 'utf-8');
const errors = [];
const warnings = [];

const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/);
if (!match) {
  console.error('오류: front matter 블록을 찾지 못했다.');
  process.exit(1);
}

const [, head, body] = match;

for (const key of ['title', 'description', 'date', 'tags', 'sources']) {
  if (!new RegExp(`^${key}:`, 'm').test(head)) {
    errors.push(`front matter에 ${key} 항목이 없다.`);
  }
}

const dateValue = (head.match(/^date:\s*(.*)$/m)?.[1] ?? '').trim().replace(/^["']|["']$/g, '');
if (dateValue && !/^\d{4}-\d{2}-\d{2}/.test(dateValue)) {
  errors.push(`date 형식이 YYYY-MM-DD가 아니다: ${dateValue}`);
}

const urlCount = (head.match(/url:\s*["']?https?:\/\//g) ?? []).length;
const bareUrlCount = (head.match(/^\s*-\s*["']?https?:\/\//gm) ?? []).length;
const sourceCount = urlCount + bareUrlCount;
if (sourceCount === 0) errors.push('sources에 유효한 URL이 하나도 없다.');
if (sourceCount === 1) warnings.push('출처가 1개뿐이다. 2개 이상을 권장한다.');

const title = (head.match(/^title:\s*(.*)$/m)?.[1] ?? '').trim().replace(/^["']|["']$/g, '');
if (title.length > 70) warnings.push(`제목이 ${title.length}자로 길다.`);

// 본문 글자 수 — 프롬프트가 말하는 "공백 포함 2,000~3,000자"와 같은 기준으로 센다.
// 마크다운 기호와 링크 URL은 글이 아니므로 빼고, 연속 공백은 하나로 눌러서 센다.
const plain = body
  .replace(/```[\s\S]*?```/g, '')
  .replace(/!?\[([^\]]*)\]\([^)]*\)/g, '$1')
  .replace(/^#{1,6}\s+/gm, '')
  .replace(/[*_`>|-]/g, '')
  .trim();

const chars = plain.replace(/\s+/g, ' ').length;
if (chars < 1400) errors.push(`본문이 ${chars}자로 너무 짧다. (기준 2,000~3,000자)`);
else if (chars < 2000) warnings.push(`본문이 ${chars}자로 기준(2,000~3,000자)에 못 미친다.`);
else if (chars > 3400) warnings.push(`본문이 ${chars}자로 기준(2,000~3,000자)을 넘는다.`);

const emoji = body.match(/\p{Extended_Pictographic}/gu);
if (emoji) errors.push(`본문에 이모지가 있다: ${[...new Set(emoji)].join(' ')}`);

if (/[!]/.test(plain.replace(/https?:\/\/\S+/g, ''))) {
  warnings.push('본문에 느낌표가 있다.');
}

const headings = [...body.matchAll(/^##\s+(.+)$/gm)].map((m) => m[1].trim());
if (headings.length < 3) warnings.push(`H2 섹션이 ${headings.length}개다. 4개 구조를 권장한다.`);

for (const w of warnings) console.log(`경고: ${w}`);
for (const e of errors) console.error(`오류: ${e}`);

console.log(`본문 ${chars}자(공백 포함) · 출처 ${sourceCount}개 · 섹션 ${headings.length}개`);
process.exit(errors.length > 0 ? 1 : 0);
