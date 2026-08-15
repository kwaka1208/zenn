---
title: タグ機能を作る
---

## タグで記事を分類する

記事が増えてくると、「カメラの記事だけ読みたい」といった**絞り込み**がほしくなります。第6章で記事のfrontmatterに `tags` を書いておいたので、これを使ってタグ機能を作りましょう。

作るページは2つです。

| ページ | URL | 内容 |
|---|---|---|
| タグ一覧 | `/tags/` | サイト内の全タグが並ぶ |
| タグ別記事一覧 | `/tags/カメラ/` など | そのタグがついた記事の一覧 |

**大事な方針**：タグの一覧を手書きのリストで管理しては**いけません**。記事に書いたタグとタグ一覧ページの内容がズレる原因になります。タグ一覧は、**全記事のfrontmatterからビルド時に自動で集計**します。記事に新しいタグを書けば、タグ一覧にも自動で現れる——そういう仕組みにします。

---

## タグ一覧ページを作る

`src/pages/tags/` フォルダを作り、`index.astro` を作ってください。

```html:src/pages/tags/index.astro
---
import { getCollection } from 'astro:content';
import BaseLayout from '../../layouts/BaseLayout.astro';

const posts = await getCollection('blog');
const allTags = [...new Set(posts.flatMap((post) => post.data.tags))];
---

<BaseLayout title="タグ一覧" description="記事のタグ一覧です。">
  <h1>タグ一覧</h1>

  <ul class="tag-list">
    {allTags.map((tag) => (
      <li>
        <a href={`/tags/${tag}/`}>#{tag}</a>
      </li>
    ))}
  </ul>
</BaseLayout>

<style>
  .tag-list {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }
  .tag-list a {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border: 1px solid var(--color-border);
    border-radius: 999px;
    background-color: var(--color-surface);
    text-decoration: none;
    font-size: 0.9rem;
  }
  .tag-list a:hover {
    border-color: var(--color-accent);
  }
</style>
```

### タグの集計：1行の中で何が起きているか

```ts
const allTags = [...new Set(posts.flatMap((post) => post.data.tags))];
```

この1行は情報が詰まっているので、分解して見てみましょう。

1. `posts.flatMap((post) => post.data.tags)`
   全記事のタグを取り出して、**1つの配列に平らに**つなげます。結果は `["お知らせ", "カメラ", "さんぽ", "コーヒー"]` のようになります。同じタグを複数の記事が使っていれば、この時点では重複して入っています。
2. `new Set(...)`
   **Set（セット）** は「重複を許さない集合」です。配列をSetに変換すると、重複したタグが自動で1つにまとまります。
3. `[...]`
   Setのままでは `map()` で表示しにくいので、`...`（スプレッド構文）で普通の配列に戻します。

「全記事からタグを集めて、重複を取り除く」を1行で書いたものです。よく使われる定番の書き方なので、パターンとして覚えてしまって大丈夫です。

---

## タグ別の記事一覧ページを作る

次に `src/pages/tags/[tag].astro` を作ります。第8章で学んだ**動的ルーティング**の応用です。今度は「記事の数だけ」ではなく「**タグの数だけ**」ページを生成します。

```html:src/pages/tags/[tag].astro
---
import { getCollection } from 'astro:content';
import BaseLayout from '../../layouts/BaseLayout.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  const allTags = [...new Set(posts.flatMap((post) => post.data.tags))];

  return allTags.map((tag) => {
    const taggedPosts = posts
      .filter((post) => post.data.tags.includes(tag))
      .sort((a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime());
    return {
      params: { tag },
      props: { posts: taggedPosts },
    };
  });
}

const { tag } = Astro.params;
const { posts } = Astro.props;
---

<BaseLayout title={`タグ: ${tag}`} description={`「${tag}」タグのついた記事の一覧です。`}>
  <h1>#{tag} の記事</h1>

  <ul class="post-list">
    {posts.map((post) => (
      <li>
        <a href={`/blog/${post.id}/`}>
          <span class="post-date">
            {post.data.pubDate.toLocaleDateString('ja-JP')}
          </span>
          <span class="post-title">{post.data.title}</span>
        </a>
      </li>
    ))}
  </ul>

  <p><a href="/tags/">← タグ一覧にもどる</a></p>
</BaseLayout>

<style>
  .post-list {
    list-style: none;
    margin: 0 0 2rem;
    padding: 0;
    display: grid;
    gap: 1rem;
  }
  .post-list a {
    display: block;
    padding: 1rem 1.25rem;
    border: 1px solid var(--color-border);
    border-radius: 8px;
    text-decoration: none;
    color: inherit;
  }
  .post-list a:hover {
    border-color: var(--color-accent);
  }
  .post-date {
    display: block;
    font-size: 0.85rem;
    color: var(--color-text-weak);
  }
  .post-title {
    display: block;
    font-weight: bold;
    margin-top: 0.25rem;
  }
</style>
```

### `getStaticPaths()` の中でやっていること

1. 全記事からタグ一覧を集計する（タグ一覧ページと同じ書き方）
2. タグごとに、`filter()` で**そのタグを含む記事だけ**を絞り込む
3. 絞り込んだ記事を新しい順に並べ替えて `props` で渡す

`filter()` は「条件に合う要素だけを残す」配列の関数、`includes()` は「配列にその値が含まれているか」を調べる関数です。

### `Astro.params`：URLの値を受け取る

```ts
const { tag } = Astro.params;
```

`Astro.params` からは、URLの `[tag]` 部分に入った値を受け取れます。`/tags/カメラ/` のページなら `tag` は `"カメラ"` です。ページの見出しに使っています。

:::message
URLに日本語（`/tags/カメラ/`）を使っていますが、ブラウザが自動的に変換（URLエンコード）してくれるので問題なく動きます。気になる方は、タグを英語（`camera` など）にしてもかまいません。
:::

---

## 記事ページにタグを表示する

最後に、記事ページ（`src/pages/blog/[id].astro`）からタグページに飛べるようにしましょう。テンプレートの `<header class="post-header">` の中に追記します。

```html:src/pages/blog/[id].astro（post-header内に追記）
<header class="post-header">
  <p class="post-date">
    {post.data.pubDate.toLocaleDateString('ja-JP')}
  </p>
  <h1>{post.data.title}</h1>
  <ul class="post-tags">
    {post.data.tags.map((tag) => (
      <li><a href={`/tags/${tag}/`}>#{tag}</a></li>
    ))}
  </ul>
</header>
```

`<style>` にも追記します。

```css
.post-tags {
  list-style: none;
  margin: 0.5rem 0 0;
  padding: 0;
  display: flex;
  gap: 0.5rem;
}
.post-tags a {
  font-size: 0.85rem;
  color: var(--color-text-weak);
  text-decoration: none;
}
.post-tags a:hover {
  color: var(--color-accent);
}
```

あわせて、`src/consts.ts` の `NAV_ITEMS` に「タグ一覧」を追加しておきましょう。

```ts:src/consts.ts（NAV_ITEMSのみ）
export const NAV_ITEMS = [
  { label: "ホーム", href: "/" },
  { label: "ブログ", href: "/blog/" },
  { label: "タグ", href: "/tags/" },
  { label: "プロフィール", href: "/about/" },
] as const;
```

---

## 動作を確認する

1. `/tags/` を開くと、記事に書いた全タグが自動で並んでいる
2. タグをクリックすると、そのタグの記事だけが一覧表示される
3. 記事ページのタグからもタグページに飛べる

試しに、どれかの記事のfrontmatterに新しいタグ（例：`tags: [コーヒー, 買い物]`）を追加してみてください。タグ一覧に「買い物」が自動で現れ、`/tags/買い物/` のページも自動で生成されます。**手作業でのタグ管理はゼロ**です。

---

## まとめ

- タグ一覧は手書きせず、`flatMap()` と `Set` で**全記事から自動集計**します
- `[tag].astro` の `getStaticPaths()` で、タグの数だけページを自動生成しました
- `filter()` と `includes()` で「そのタグを含む記事」を絞り込みます
- `Astro.params` でURL中の値（タグ名）を受け取れます

次の章では、ここまで一切書いてこなかった「ブラウザで動くJavaScript」を初めて導入し、ダークモード切り替えを作ります。
