import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { getPublishedPosts } from '../lib/posts';
import { href } from '../lib/url';
import { SITE_TITLE, SITE_DESCRIPTION } from '../consts';

export async function GET(context: APIContext) {
  const posts = await getPublishedPosts();

  return rss({
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    // 채널 주소는 base 를 포함한 사이트 루트여야 한다. context.site 는 오리진뿐이다.
    site: new URL(href('/'), context.site!).href,
    trailingSlash: true,
    customData: '<language>ko</language>',
    items: posts.slice(0, 50).map((post) => ({
      title: post.data.title,
      description: post.data.description,
      pubDate: post.data.date,
      link: href(`/posts/${post.id}/`),
      categories: post.data.tags,
    })),
  });
}
