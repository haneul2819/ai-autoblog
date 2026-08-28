// content/drafts 까지 포함해서 astro 를 돌린다. 검토용 미리보기 전용.
// 윈도우에서도 되도록 환경 변수를 셸이 아니라 여기서 넣는다.
//   node scripts/with-drafts.mjs dev
//   node scripts/with-drafts.mjs build
import { spawn } from 'node:child_process';

const child = spawn('npx', ['astro', ...process.argv.slice(2)], {
  stdio: 'inherit',
  shell: true,
  env: { ...process.env, INCLUDE_DRAFTS: '1' },
});

child.on('exit', (code) => process.exit(code ?? 0));
