import config from '../config.json';

export const SITE_URL: string = config.site.url;
export const SITE_TITLE: string = config.site.title;
export const SITE_DESCRIPTION: string = config.site.description;
export const SITE_AUTHOR: string = config.site.author;

// path 는 base 경로를 뺀 값이다. 링크로 쓸 때 href() 를 통과시킨다.
export const NAV = [
  { path: '/', label: '글 목록' },
  { path: '/tags/', label: '태그' },
  { path: '/about/', label: '소개' },
] as const;
