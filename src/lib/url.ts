/**
 * 사이트 안쪽 링크에 base 경로를 붙인다.
 *
 * GitHub Pages 프로젝트 사이트처럼 하위 경로(/ai-autoblog)에 배포되면
 * `href="/tags/"` 같은 절대 경로가 도메인 루트를 가리켜 깨진다.
 * base 가 없는 배포(Vercel, 커스텀 도메인)에서는 받은 경로를 그대로 돌려준다.
 */
export function href(path: string): string {
  const base = import.meta.env.BASE_URL.replace(/\/+$/, '');
  const rest = path.startsWith('/') ? path : `/${path}`;
  return `${base}${rest}`;
}
