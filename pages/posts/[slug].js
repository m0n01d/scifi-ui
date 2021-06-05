import { useRouter } from "next/router";
import Head from "next/head";
import ErrorPage from "next/error";
import { getPostBySlug, getAllPosts } from "../../lib/api";
import markdownToHtml from "../../lib/markdownToHtml";

export default function Post({ post, morePosts, preview }) {
  const router = useRouter();
  if (!router.isFallback && !post?.slug) {
    return <ErrorPage statusCode={404} />;
  }
  return (
    <div className="px-4 font-mono Layout">
      {router.isFallback ? (
        <p>loading...</p>
      ) : (
        <article className="md:w-1/2">
          {post.title}
          <div dangerouslySetInnerHTML={{ __html: post.content }}></div>
        </article>
      )}
    </div>
  );
}

export async function getStaticProps({ params }) {
  const post = getPostBySlug(params.slug, ["title", "content", "slug"]);

  const content = await markdownToHtml(post.content || "");
  return {
    props: {
      post: {
        ...post,
        content,
      },
    },
  };
}
export async function getStaticPaths() {
  const posts = getAllPosts(["slug"]);
  return {
    paths: posts.map((post) => {
      return {
        params: {
          slug: post ? post.slug : "",
        },
      };
    }),
    fallback: false,
  };
}
