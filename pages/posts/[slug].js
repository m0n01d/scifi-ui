import { useRouter } from "next/router";
import Head from "next/head";
import ErrorPage from "next/error";
import { getPostBySlug, getAllPosts } from "../../lib/api";
import markdownToHtml from "../../lib/markdownToHtml";

export default function Post({ post, morePosts, preview }) {
  const router = useRouter();
  if (!router.isFallback && !post?.slug) {
    {
      console.log(post);
    }
    return <ErrorPage statusCode={404} />;
  }
  return (
    <div className="Layout">
      {router.isFallback ? <p>loading...</p> : <article>post.title</article>}
    </div>
  );
}

export async function getStaticProps({ params }) {
  {console.log('getstaticshit');}
  const post = getPostBySlug(params.slug, ["title"]);

  const content = await markdownToHtml(post.content || "");
  console.log({ content, post });
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
    paths: paths.map((post) => {
      return {
        params: {
          slug: post.slug,
        },
      };
    }),
    fallback: false,
  };
}
