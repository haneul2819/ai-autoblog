// 최근 글의 날짜·제목·태그를 뽑아 프롬프트에 넣을 목록으로 찍는다.
// 사용법: node scripts/recent-posts.mjs [저장소루트] [편수]
import { readdirSync, readFileSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const root = process.argv[2] ?? '.';
const limit = Number(process.argv[3] ?? 60);

// 초안도 함께 본다. 검토 모드로 돌리는 동안에도 같은 주제를 두 번 쓰지 않도록.
const dirs = ['content/posts', 'content/drafts'];

const entries = [];

for (const dir of dirs) {
  const abs = join(root, dir);
  if (!existsSync(abs)) continue;

  for (const name of readdirSync(abs)) {
    if (!name.endsWith('.md')) continue;
    const raw = readFileSync(join(abs, name), 'utf-8');
    const fm = parseFrontMatter(raw);
    entries.push({
      file: name,
      date: fm.date || name.slice(0, 10),
      title: fm.title || name.replace(/\.md$/, ''),
      tags: fm.tags,
    });
  }
}

entries.sort((a, b) => (a.date < b.date ? 1 : a.date > b.date ? -1 : b.file.localeCompare(a.file)));

const recent = entries.slice(0, limit);

if (recent.length === 0) {
  console.log('(아직 발행된 글이 없다. 이번이 첫 글이다.)');
} else {
  for (const e of recent) {
    const tags = e.tags.length ? ` [${e.tags.join(', ')}]` : '';
    console.log(`- ${e.date} ${e.title}${tags}`);
  }
}

/** 의존성 없이 front matter만 최소한으로 읽는다. YAML 전체를 해석하지는 않는다. */
function parseFrontMatter(raw) {
  const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!match) return { title: '', date: '', tags: [] };

  const lines = match[1].split(/\r?\n/);
  const out = { title: '', date: '', tags: [] };

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    const title = line.match(/^title:\s*(.*)$/);
    if (title) out.title = unquote(title[1]);

    const date = line.match(/^date:\s*(.*)$/);
    if (date) out.date = unquote(date[1]).slice(0, 10);

    const tags = line.match(/^tags:\s*(.*)$/);
    if (tags) {
      const inline = unquote(tags[1]).trim();
      if (inline.startsWith('[')) {
        out.tags = inline
          .slice(1, -1)
          .split(',')
          .map((t) => unquote(t.trim()))
          .filter(Boolean);
      } else {
        // 블록 목록 형태: 다음 줄부터 "- 값"
        for (let j = i + 1; j < lines.length; j++) {
          const item = lines[j].match(/^\s*-\s*(.+)$/);
          if (!item) break;
          out.tags.push(unquote(item[1].trim()));
        }
      }
    }
  }

  return out;
}

function unquote(value) {
  return value.trim().replace(/^["']|["']$/g, '');
}
