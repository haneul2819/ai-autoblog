import type { APIContext } from 'astro';
import { getPublishedPosts, groupByTag, isoDate } from '../lib/posts';

const PAGE_SIZE = 12; // [...page].astro 와 같은 값이어야 한다.

export async function GET(context: APIContext) {
  const site = context.site!;
  const posts = await getPublishedPosts();
  const tags = groupByTag(posts);

  const newest = posts[0] ? isoDate(posts[0].data.date) : undefined;
  const lastPage = Math.max(1, Math.ceil(posts.length / PAGE_SIZE));

  const entries: { path: string; lastmod?: string }[] = [
    { path: '/', lastmod: newest },
    { path: '/about/' },
    { path: '/tags/', lastmod: newest },
  ];

  for (let page = 2; page <= lastPage; page++) {
    entries.push({ path: `/${page}/` });
  }

  for (const post of posts) {
    entries.push({ path: `/posts/${post.id}/`, lastmod: isoDate(post.data.date) });
  }

  for (const { tag, posts: tagged } of tags) {
    entries.push({
      path: `/tags/${encodeURIComponent(tag)}/`,
      lastmod: tagged[0] ? isoDate(tagged[0].data.date) : undefined,
    });
  }

  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${entries
  .map(({ path, lastmod }) => {
    const loc = new URL(path, site).href;
    return `  <url>\n    <loc>${escapeXml(loc)}</loc>${
      lastmod ? `\n    <lastmod>${lastmod}</lastmod>` : ''
    }\n  </url>`;
  })
  .join('\n')}
</urlset>
`;

  return new Response(body, {
    headers: { 'Content-Type': 'application/xml; charset=utf-8' },
  });
}

function escapeXml(value: string): string {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}
