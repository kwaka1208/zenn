---
title: 公開前の仕上げ：404・サイトマップ・RSS
---

## 「ちゃんとしたサイト」に見える仕上げ

サイトの機能はほぼ完成しました。この章では、公開する前に整えておきたい3つの要素を追加します。

| 要素 | 役割 |
|---|---|
| 404ページ | 存在しないURLにアクセスされたときの案内 |
| サイトマップ | 検索エンジンにページ一覧を伝えるファイル |
| RSSフィード | 更新情報を購読してもらうための仕組み |

どれも一度設定すれば、あとは自動でメンテナンスされるものばかりです。

---

## 404ページを作る

存在しないURL（たとえば `/xyz/`）にアクセスすると、今は素っ気ないエラー画面が表示されます。`src/pages/404.astro` というファイルを作ると、Astroが「ページが見つからないときのページ」として使ってくれます。

```html:src/pages/404.astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="ページが見つかりません">
  <div class="not-found">
    <h1>404</h1>
    <p>お探しのページは見つかりませんでした。</p>
    <p>URLが変更されたか、削除された可能性があります。</p>
    <p><a href="/">トップページにもどる</a></p>
  </div>
</BaseLayout>

<style>
  .not-found {
    text-align: center;
    padding: 4rem 0;
  }
  .not-found h1 {
    font-size: 4rem;
    margin: 0;
    color: var(--color-text-weak);
  }
</style>
```

開発サーバーで `http://localhost:4321/xyz` などを開くと、作った404ページが表示されます。ヘッダー・フッター付きなので、迷い込んだ訪問者もすぐサイト内に戻れます。

---

## サイトのURLを設定する

サイトマップとRSSは「サイトの正式なURL」を必要とします。`astro.config.mjs` に `site` を設定しましょう。

次の章でGitHub Pagesに公開すると、サイトのURLは `https://あなたのユーザー名.github.io` になります（詳しくは次章で説明します）。GitHubのユーザー名が `yamada-taro` なら次のようになります。

```js:astro.config.mjs
// @ts-check
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://yamada-taro.github.io',
});
```

:::message
まだGitHubのアカウントを持っていない場合は、ここでは仮のURLのままにして、次の章でアカウントを作ってから書き換えても大丈夫です。
:::

---

## サイトマップを自動生成する

**サイトマップ**は、サイト内の全ページのURLを列挙したファイル（`sitemap.xml`）です。GoogleやBingなどの検索エンジンはこのファイルを読んで、サイトのページを漏れなく見つけます。検索結果に載りたいなら用意しておきたいファイルです。

Astroでは公式の追加機能（**インテグレーション**と呼びます）を1コマンドで導入できます。開発サーバーを `Ctrl + C` で止めて、次を実行してください。

```bash
npx astro add sitemap
```

「設定ファイルを変更してよいか」と確認されるので、`y` で進めてください。完了すると、`astro.config.mjs` が自動で次のように書き換わっています。

```js:astro.config.mjs
// @ts-check
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://yamada-taro.github.io',
  integrations: [sitemap()],
});
```

これだけで、サイトをビルドするたびに全ページのサイトマップが自動生成されます。ページを増やしても手作業は不要です。

なお、サイトマップは**ビルド時に生成される**ため、開発サーバーでは確認できません。あとで確認する方法はこの章の最後で紹介します。

---

## RSSフィードを作る

**RSS**は、サイトの更新情報を機械が読める形式で配信する仕組みです。RSSリーダー（Feedlyなど）と呼ばれるアプリでいろいろなサイトのRSSを購読すると、お気に入りのサイトの新着記事をまとめてチェックできます。個人サイトとの相性が良く、根強い人気があります。

まず公式パッケージをインストールします。

```bash
npm install @astrojs/rss
```

次に、`src/pages/rss.xml.js` というファイルを作ります。

```js:src/pages/rss.xml.js
import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { SITE } from '../consts';

export async function GET(context) {
  const posts = await getCollection('blog');
  const sortedPosts = posts.sort(
    (a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime()
  );

  return rss({
    title: SITE.title,
    description: SITE.description,
    site: context.site,
    items: sortedPosts.map((post) => ({
      title: post.data.title,
      pubDate: post.data.pubDate,
      description: post.data.description,
      link: `/blog/${post.id}/`,
    })),
  });
}
```

### `.astro` ではないページ？

このファイルの拡張子は `.js` です。`src/pages/` に置いた `rss.xml.js` は、「`/rss.xml` というURLで、`GET` 関数が作った内容を返すページ」になります。HTMLではないファイル（XMLやJSONなど）を生成したいときの書き方です。

中身は見覚えのあるコードばかりです。`getCollection('blog')` で記事を取得して新しい順に並べ、`rss()` 関数にサイト情報と記事一覧を渡しています。`context.site` には、先ほど `astro.config.mjs` に設定した `site` のURLが自動で入ります。

サイト名や説明文を `SITE` から参照している点にも注目してください。`consts.ts` に情報を集約してきたおかげで、RSSにも同じ情報がそのまま使えます。

開発サーバーを起動して `http://localhost:4321/rss.xml` を開くと、記事一覧のXMLが表示されます。

### フィードの存在をブラウザに知らせる

最後に、`BaseLayout.astro` の `<head>` に1行追加して、RSSフィードの場所をブラウザやRSSリーダーに知らせます。

```html:src/layouts/BaseLayout.astro（head内に追記）
<link rel="alternate" type="application/rss+xml" title={SITE.title} href={new URL('rss.xml', Astro.site)} />
```

これで、RSSリーダーにサイトのURLを入れるだけでフィードを見つけてもらえるようになります。

---

## ビルドして全体を確認する

公開前に、一度手元で**本番用のビルド**を実行してみましょう。

```bash
npm run build
```

成功すると、`dist/` フォルダに完成品のサイト（HTML・CSS・最適化された画像・`sitemap-index.xml`・`rss.xml`）が出力されます。これが実際にインターネットに公開されるファイル一式です。

ビルド結果は次のコマンドでプレビューできます。

```bash
npm run preview
```

表示されたURL（`http://localhost:4321/`）で、本番と同じ状態のサイトを確認できます。`http://localhost:4321/sitemap-index.xml` でサイトマップも確認してみてください。

| コマンド | 役割 |
|---|---|
| `npm run dev` | 開発サーバー（書きながら確認する用） |
| `npm run build` | 本番用ファイルを `dist/` に生成 |
| `npm run preview` | ビルド結果を手元で確認 |

---

## まとめ

- `src/pages/404.astro` で「ページが見つからない」ときの案内ページを作りました
- `astro.config.mjs` の `site` にサイトの正式URLを設定しました
- `npx astro add sitemap` でサイトマップを自動生成するようにしました
- `@astrojs/rss` と `src/pages/rss.xml.js` でRSSフィードを配信できるようにしました
- `npm run build` で本番用ファイルを生成し、`npm run preview` で確認しました

いよいよ次の章で、サイトをインターネットに公開します。
