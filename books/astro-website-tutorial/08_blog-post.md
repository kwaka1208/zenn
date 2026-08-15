---
title: 記事ページと動的ルーティング
---

## 1つのファイルで全記事のページを作る

記事の個別ページを作ります。とはいえ、記事が増えるたびに `.astro` ファイルを手で増やすわけにはいきません。

Astroには**動的ルーティング**という仕組みがあり、**1つのファイルで「記事の数だけページを自動生成」** できます。ファイル名に `[ ]`（角かっこ）を使うのが目印です。

| ファイル | 生成されるページ |
|---|---|
| `src/pages/blog/[id].astro` | `/blog/first-post/`、`/blog/camera-walk/`、… 記事の数だけ |

---

## 記事ページを作る

`src/pages/blog/[id].astro` を作ってください。ファイル名に角かっこを含めて、そのまま `[id].astro` という名前にします。

```html:src/pages/blog/[id].astro
---
import { getCollection, render } from 'astro:content';
import BaseLayout from '../../layouts/BaseLayout.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map((post) => ({
    params: { id: post.id },
    props: { post },
  }));
}

const { post } = Astro.props;
const { Content } = await render(post);
---

<BaseLayout title={post.data.title} description={post.data.description}>
  <article>
    <header class="post-header">
      <p class="post-date">
        {post.data.pubDate.toLocaleDateString('ja-JP')}
      </p>
      <h1>{post.data.title}</h1>
    </header>

    <div class="post-body">
      <Content />
    </div>
  </article>

  <p class="back-link"><a href="/blog/">← 記事一覧にもどる</a></p>
</BaseLayout>

<style>
  .post-header {
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid var(--color-border);
  }
  .post-date {
    color: var(--color-text-weak);
    font-size: 0.9rem;
    margin: 0;
  }
  .post-header h1 {
    margin: 0.25rem 0 0;
  }
  .back-link {
    margin-top: 3rem;
  }
</style>
```

保存して、記事一覧から記事をクリックしてみてください。今度は404にならず、記事の本文が表示されます。

このファイルには新しい仕組みが2つ入っています。順番に説明します。

---

## `getStaticPaths()`：どのページを作るかの一覧を渡す

```ts
export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map((post) => ({
    params: { id: post.id },
    props: { post },
  }));
}
```

`[id].astro` のような動的ルートのファイルでは、**「どんなURLのページを作るのか」をAstroに教える必要があります**。それがこの `getStaticPaths()`（静的パスの取得）という関数です。

やっていることはこうです。

1. `getCollection('blog')` で全記事を取得する
2. 記事ごとに `{ params: { id: 記事のID }, props: { post: 記事データ } }` という形のオブジェクトを作って返す

- **`params`**：URLの `[id]` の部分に入る値。`post.id` が `first-post` なら `/blog/first-post/` というページが作られます
- **`props`**：そのページに渡すデータ。ここで記事データを丸ごと渡しておくと、ページ側で `Astro.props` から受け取れます

Astroはビルド時にこの一覧を見て、**記事の数だけHTMLファイルを生成**します。記事を増やせば、ページも自動で増えます。

```ts
const { post } = Astro.props;
```

`getStaticPaths()` の `props` で渡した記事データを、ここで受け取っています。

---

## `render()`：Markdownを表示できる形にする

```ts
import { getCollection, render } from 'astro:content';

const { Content } = await render(post);
```

記事の本文はMarkdownのままではただの文字列です。`render(post)` に記事を渡すと、Markdownを変換した **`<Content />` というコンポーネント**が手に入ります。

テンプレート側で `<Content />` を置いた場所に、記事本文がHTMLとして表示されます。`## 見出し` は `<h2>` に、`**太字**` は `<strong>` に、Markdownの記法がきちんとHTMLに変換されています。

---

## 記事本文にスタイルを当てる：`:global()` の話

記事本文の見た目を整えようとすると、Astro特有の注意点に出会います。試しに、`[id].astro` の `<style>` に次のように書いても**効きません**。

```css
/* これは効かない */
.post-body h2 {
  border-bottom: 2px solid var(--color-accent);
}
```

なぜでしょうか。スコープ付きスタイルは「このファイルに書かれたHTMLタグ」だけに効く仕組みです。ところが記事本文の `<h2>` は、Markdownから**変換されて生まれたHTML**です。このファイルに直接書かれたタグではないため、スコープの対象外なのです。

こういうときは `:global()` を使って「この部分はスコープの外にも効かせる」と明示します。`[id].astro` の `<style>` に追記してください。

```css
.post-body :global(h2) {
  margin-top: 2.5rem;
  padding-bottom: 0.25rem;
  border-bottom: 2px solid var(--color-accent);
  font-size: 1.3rem;
}
.post-body :global(p) {
  margin: 1rem 0;
}
```

`.post-body :global(h2)` は「`.post-body` の中にある `<h2>` なら、どこから生まれたHTMLでも適用する」という意味になります。`.post-body` で範囲を限定しているので、記事本文の外に影響が漏れる心配もありません。

保存すると、記事の見出しに下線がつきました。

:::message
「Markdownから生成されたHTMLにはスコープ付きスタイルが効かない」は、Astroでブログを作るときに誰もが一度はつまずくポイントです。「本文のスタイルは `:global()` で当てる」と覚えておいてください。
:::

---

## 動作をまとめて確認する

ここまでで、ブログの基本機能が完成しました。

1. `/blog/` で記事一覧が新しい順に表示される
2. 記事をクリックすると `/blog/記事ID/` の個別ページが開く
3. 記事ページから「記事一覧にもどる」で戻れる

試しに、`src/content/blog/` に4つ目のMarkdownファイルを追加してみてください。一覧にも個別ページにも、**コードを1行も変えずに**自動で反映されます。これがContent Collections＋動的ルーティングの力です。

---

## まとめ

- ファイル名に `[id]` を含めると、1つのファイルで複数のページを生成できます（動的ルーティング）
- `getStaticPaths()` で「どのURLのページを作るか」の一覧をAstroに渡します
- `render(post)` でMarkdown本文を `<Content />` コンポーネントに変換します
- Markdown由来のHTMLへのスタイルは `:global()` を使って当てます

次の章では、サイトに画像を追加して、Astroの画像最適化機能を学びます。
