import type { APIContext } from 'astro';
import { href } from '../lib/url';

// config.json 의 주소가 바뀌면 sitemap 줄도 따라 바뀌도록 정적 파일 대신 엔드포인트로 둔다.
export async function GET(context: APIContext) {
  const sitemap = new URL(href('/sitemap.xml'), context.site!).href;

  return new Response(`User-agent: *\nAllow: /\n\nSitemap: ${sitemap}\n`, {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' },
  });
}
