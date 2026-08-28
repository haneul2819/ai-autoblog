import config from '../config.json';

export const SITE_URL: string = config.site.url;
export const SITE_TITLE: string = config.site.title;
export const SITE_DESCRIPTION: string = config.site.description;
export const SITE_AUTHOR: string = config.site.author;

export const NAV = [
  { href: '/', label: '글 목록' },
  { href: '/tags', label: '태그' },
  { href: '/about', label: '소개' },
] as const;
