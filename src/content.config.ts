import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

// INCLUDE_DRAFTS=1 이면 초안까지 함께 읽는다. 검토용 미리보기 전용이고,
// 실제 배포 빌드에서는 켜지 않는다. (npm run dev:drafts / build:drafts)
const includeDrafts = process.env.INCLUDE_DRAFTS === '1';

// 출처는 문자열(URL)로도, { title, url } 객체로도 쓸 수 있게 열어 둔다.
// 생성된 front matter가 두 형태 중 하나로 흔들려도 빌드가 깨지지 않도록.
const source = z.union([
  z.string(),
  z.object({
    title: z.string().optional(),
    url: z.string(),
  }),
]);

const posts = defineCollection({
  // 글의 실체는 저장소 루트의 content/posts/*.md 다.
  loader: glob({
    pattern: includeDrafts ? '{posts,drafts}/**/*.md' : 'posts/**/*.md',
    base: './content',
    // 어느 폴더에 있든 주소는 파일 이름으로만 정해진다.
    // 초안을 content/posts 로 옮겨도 주소가 바뀌지 않는다.
    generateId: ({ entry }) => entry.replace(/\.md$/, '').split('/').pop()!,
  }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    tags: z.array(z.string()).default([]),
    sources: z.array(source).default([]),
    // 파일이 content/posts 에 있어도 개별적으로 감출 수 있는 탈출구
    draft: z.boolean().default(false),
  }),
});

export const collections = { posts };
