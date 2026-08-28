// @ts-check
import { readFileSync } from 'node:fs';
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

const config = JSON.parse(
  readFileSync(new URL('./config.json', import.meta.url), 'utf-8'),
);

export default defineConfig({
  site: config.site.url,
  integrations: [sitemap()],
  markdown: {
    shikiConfig: {
      themes: { light: 'github-light', dark: 'github-dark' },
      wrap: true,
    },
  },
});
