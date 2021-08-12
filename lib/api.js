import fs from "fs";
import { join } from "path";

import matter from "gray-matter";

const postsDirectory = join(process.cwd(), "__posts");

export function getPostSlugs() {
  return fs.readdirSync(postsDirectory, { withFileTypes: true });
}

export function getPostBySlug(slug, fields = []) {
  const name = slug.name ? slug.name : slug;
  if (name.includes(".DS_Store")) return;
  const realSlug = name.replace(/\.md$/, "");
  const fullPath = join(postsDirectory, name, `${realSlug}.mdx`);
  const fileContents = fs.readFileSync(fullPath, "utf8");
  const { data, content } = matter(fileContents);
  const items = {};

  // Ensure only the minimal needed data is exposed
  fields.forEach((field) => {
    if (field === "slug") {
      items[field] = realSlug;
    }
    if (field === "content") {
      items[field] = content;
    }

    if (data[field]) {
      items[field] = data[field];
    }
  });

  return items;
}
export function getAllPosts(fields = []) {
  const slugs = getPostSlugs("");
  const posts = slugs
    .map((slug) => getPostBySlug(slug, fields))
    // sort posts by date in descending order
    .sort((post1, post2) => (post1.date > post2.date ? -1 : 1));
  return posts;
}
