---
title: ブログの記事一覧ページ
---

## 記事一覧ページを作る

前の章で用意した記事たちを、一覧ページに表示します。作るのは `/blog/` というURLのページです。

`src/pages/blog/` フォルダを作り、その中に `index.astro` を作ってください。

```html:src/pages/blog/index.astro
---
import { getCollection } from 'astro:content';
import BaseLayout from '../../layouts/BaseLayout.astro';

const posts = await getCollection('blog');
const sortedPosts = posts.sort(
  (a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime()
);
---

<BaseLayout title="ブログ" description="記事の一覧です。">
  <h1>ブログ</h1>

  <ul class="post-list">
    {sortedPosts.map((post) => (
      <li>
        <a href={`/blog/${post.id}/`}>
          <span class="post-date">
            {post.data.pubDate.toLocaleDateString('ja-JP')}
          </span>
          <span class="post-title">{post.data.title}</span>
          <span class="post-description">{post.data.description}</span>
        </a>
      </li>
    ))}
  </ul>
</BaseLayout>

<style>
  .post-list {
    list-style: none;
    margin: 0;
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
    font-size: 1.1rem;
    margin: 0.25rem 0;
  }
  .post-description {
    display: block;
    font-size: 0.9rem;
    color: var(--color-text-weak);
  }
</style>
```

ブラウザで `http://localhost:4321/blog/` を開くと、記事が新しい順に3件並んでいるはずです。コードのポイントを見ていきましょう。

---

## `getCollection()`：記事をまとめて取得する

```ts
import { getCollection } from 'astro:content';

const posts = await getCollection('blog');
```

`getCollection('blog')` は、blogコレクション（`src/content/blog/` の記事）を**全件取得**する関数です。

- `astro:content` はAstroが用意している記事管理用のモジュールです
- `await` は「取得が終わるまで待つ」という意味のキーワードです。`getCollection()` は非同期（結果が返るまで少し時間がかかる）関数なので、`await` を忘れるとデータが取れません

この処理は**ビルド時に実行される**ことを思い出してください。訪問者がページを開くたびに記事を読み込むのではなく、サイトを作る時点で一覧が完成しています。だから表示が速いのです。

### 取得した記事の中身

`getCollection()` が返す各記事（`post`）は、次のような構造をしています。

| プロパティ | 内容 | 例 |
|---|---|---|
| `post.id` | ファイル名から決まる記事のID | `first-post` |
| `post.data` | frontmatterの内容 | `post.data.title` など |
| `post.body` | Markdown本文（生テキスト） | |

frontmatterに書いた情報は `post.data` にまとまっています。スキーマを定義したおかげで、`post.data.pubDate` は**Date型（日付オブジェクト）** として扱えます。

---

## 記事を新しい順に並べ替える

```ts
const sortedPosts = posts.sort(
  (a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime()
);
```

`getCollection()` の結果の並び順は保証されていないので、自分で並べ替えます。

- `sort()` は配列を並べ替えるJavaScriptの関数です
- `getTime()` は日付を数値（1970年からの経過ミリ秒）に変換します
- `b - a` の順で引き算すると**大きい順（＝新しい順）** になります

### 日付の表示

```ts
post.data.pubDate.toLocaleDateString('ja-JP')
```

`toLocaleDateString('ja-JP')` は、日付を「2026/8/5」のような日本語圏の形式の文字列にしてくれます。

---

## 記事ページへのリンク

```html
<a href={`/blog/${post.id}/`}>
```

各記事へのリンク先は `/blog/記事のID/` です。`` `...${ }...` ``（バッククォートと `${ }`）は**テンプレートリテラル**という書き方で、文字列の中に変数を埋め込めます。たとえば `post.id` が `first-post` なら、リンク先は `/blog/first-post/` になります。

ただし、今クリックすると404エラー（ページが見つからない）になります。**記事の個別ページはまだ作っていない**からです。次の章で作ります。

---

## ナビゲーションにブログを追加する

ヘッダーのメニューからブログ一覧に行けるようにしましょう。`src/consts.ts` の `NAV_ITEMS` に1行追加するだけです。

```ts:src/consts.ts（NAV_ITEMSのみ）
export const NAV_ITEMS = [
  { label: "ホーム", href: "/" },
  { label: "ブログ", href: "/blog/" },
  { label: "プロフィール", href: "/about/" },
] as const;
```

保存すると、ヘッダーに「ブログ」が増えています。ヘッダーのコンポーネントには一切触っていません。第3章で「ナビゲーションはデータとして1か所にまとめる」設計にしておいた効果がここで効いています。

---

## まとめ

- `getCollection('blog')` で記事を全件取得できます（`await` を忘れずに）
- 記事のfrontmatterは `post.data`、記事のIDは `post.id` で参照します
- `sort()` と `getTime()` で記事を新しい順に並べました
- 記事一覧はビルド時に生成されるので、表示が速いままです

次の章では、記事の本文を表示する個別ページを「動的ルーティング」で作ります。
