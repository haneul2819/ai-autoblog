// @ts-check
import { readFileSync } from 'node:fs';
import { defineConfig } from 'astro/config';

const config = JSON.parse(
  readFileSync(new URL('./config.json', import.meta.url), 'utf-8'),
);

// sitemap.xml 과 rss.xml 은 src/pages 의 엔드포인트가 직접 만든다.
// 절대 주소를 쓰므로 site 값이 실제 배포 주소와 같아야 한다.
const includeDrafts = process.env.INCLUDE_DRAFTS === '1';

export default defineConfig({
  site: config.site.url,
  // 초안 미리보기는 콘텐츠 캐시를 따로 쓴다. 같은 캐시를 나눠 쓰면 패턴이 바뀌어도
  // 스스로 비워지지 않아, 미리보기 뒤의 빌드에 초안이 남는다.
  cacheDir: includeDrafts ? './node_modules/.astro-drafts' : './node_modules/.astro',
  markdown: {
    shikiConfig: {
      themes: { light: 'github-light', dark: 'github-dark' },
      wrap: true,
    },
  },
});
