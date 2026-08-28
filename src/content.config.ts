import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

// 출처는 문자열(URL)로도, { title, url } 객체로도 쓸 수 있게 열어 둔다.
// 생성 스크립트가 만든 front matter가 두 형태 중 하나로 흔들려도 빌드가 깨지지 않도록.
const source = z.union([
  z.string(),
  z.object({
    title: z.string().optional(),
    url: z.string(),
  }),
]);

const posts = defineCollection({
  // 글의 실체는 저장소 루트의 content/posts/*.md 다.
  loader: glob({ pattern: '**/*.md', base: './content/posts' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    tags: z.array(z.string()).default([]),
    sources: z.array(source).default([]),
    // 파일이 content/posts/ 에 있어도 개별적으로 감출 수 있는 탈출구
    draft: z.boolean().default(false),
  }),
});

export const collections = { posts };
