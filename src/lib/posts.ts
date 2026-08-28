import { getCollection, type CollectionEntry } from 'astro:content';

export type Post = CollectionEntry<'posts'>;

/** draft 표시가 없는 글만, 최신순으로. */
export async function getPublishedPosts(): Promise<Post[]> {
  const posts = await getCollection('posts', ({ data }) => data.draft !== true);
  return posts.sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
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
