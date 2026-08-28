import { getCollection, type CollectionEntry } from 'astro:content';

export type Post = CollectionEntry<'posts'>;

const includeDrafts = process.env.INCLUDE_DRAFTS === '1';

/**
 * 사이트에 내보낼 글만, 최신순으로.
 *
 * 초안은 content.config.ts의 glob 패턴에서 이미 빠지지만, Astro의 콘텐츠 캐시
 * (node_modules/.astro/data-store.json)는 패턴이 바뀌어도 스스로 비워지지 않는다.
 * 미리보기를 한 번 돌린 뒤 그냥 빌드하면 초안이 배포본에 섞여 들어간다.
 * 그래서 파일이 어느 폴더에 있는지로 한 번 더 거른다.
 */
export async function getPublishedPosts(): Promise<Post[]> {
  const posts = await getCollection('posts', ({ data }) => data.draft !== true);
  return posts
    .filter((post) => includeDrafts || !isDraftFile(post))
    .sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
}

function isDraftFile(post: Post): boolean {
  // filePath는 프로젝트 루트 기준 상대 경로로 오지만, 절대 경로여도 걸리도록 둔다.
  return /(^|\/)content\/drafts\//.test((post.filePath ?? '').replace(/\\/g, '/'));
}

/** front matter의 sources는 문자열이거나 { title, url } 객체다. 한 형태로 펴 준다. */
export function normalizeSources(
  sources: Post['data']['sources'],
): { title: string; url: string }[] {
  return (sources ?? [])
    .map((s) => (typeof s === 'string' ? { url: s, title: undefined } : s))
    .filter((s) => typeof s.url === 'string' && s.url.length > 0)
    .map((s) => ({ url: s.url, title: s.title?.trim() || hostOf(s.url) }));
}

function hostOf(url: string): string {
  try {
    return new URL(url).hostname.replace(/^www\./, '');
  } catch {
    return url;
  }
}

/** 날짜만 담긴 값이라 UTC 기준으로 읽어야 시간대에 따라 하루 밀리지 않는다. */
export function formatDate(date: Date): string {
  const y = date.getUTCFullYear();
  const m = String(date.getUTCMonth() + 1).padStart(2, '0');
  const d = String(date.getUTCDate()).padStart(2, '0');
  return `${y}. ${m}. ${d}.`;
}

export function isoDate(date: Date): string {
  return date.toISOString().slice(0, 10);
}

/** 한국어 읽기 속도를 분당 500자로 잡는다. */
export function readingMinutes(body: string | undefined): number {
  const chars = (body ?? '').replace(/\s+/g, '').length;
  return Math.max(1, Math.round(chars / 500));
}

/** 태그 → 글 목록. 태그는 등장 횟수가 많은 순, 같으면 가나다순. */
export function groupByTag(posts: Post[]): { tag: string; posts: Post[] }[] {
  const map = new Map<string, Post[]>();
  for (const post of posts) {
    for (const tag of post.data.tags) {
      const key = tag.trim();
      if (!key) continue;
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(post);
    }
  }
  return [...map.entries()]
    .map(([tag, list]) => ({ tag, posts: list }))
    .sort((a, b) => b.posts.length - a.posts.length || a.tag.localeCompare(b.tag, 'ko'));
}
