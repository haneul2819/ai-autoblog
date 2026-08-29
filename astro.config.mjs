// @ts-check
import { readFileSync } from 'node:fs';
import { defineConfig } from 'astro/config';

const config = JSON.parse(
  readFileSync(new URL('./config.json', import.meta.url), 'utf-8'),
);

// config.json 의 site.url 하나에서 site 와 base 를 뽑는다.
// 예) https://haneul2819.github.io/ai-autoblog → site 는 오리진, base 는 /ai-autoblog
//     https://ai-autoblog.vercel.app          → site 는 오리진, base 는 없음
// 나중에 커스텀 도메인이나 Vercel로 옮길 때 config.json 한 줄만 고치면 된다.
const siteUrl = new URL(config.site.url);
const basePath = siteUrl.pathname.replace(/\/+$/, '');

const includeDrafts = process.env.INCLUDE_DRAFTS === '1';

// sitemap.xml 과 rss.xml 은 src/pages 의 엔드포인트가 직접 만든다.
export default defineConfig({
  site: siteUrl.origin,
  base: basePath || undefined,
  trailingSlash: 'ignore',
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
