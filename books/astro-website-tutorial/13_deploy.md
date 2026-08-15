---
title: GitHub Pagesで公開する
---

## サイトをインターネットに公開する

いよいよ最終工程、サイトの公開です。今回は**GitHub Pages**という無料のホスティングサービスを使います。

公開の流れは次のとおりです。

1. GitHubにアカウントを作る（持っていない場合）
2. サイトのコードをGitHubにアップロード（push）する
3. GitHub Actionsという仕組みが自動でビルドして公開する

一度設定してしまえば、以降は**コードをpushするだけで自動的にサイトが更新される**ようになります。記事を書いてpushすれば公開、という快適な運用です。

### 前提：Gitの基本操作

この章では、Gitの基本的な操作（`git add`・`git commit`・`git push`）を使います。Gitに慣れていない方は、コマンドをそのまま入力すれば進められるようにしてありますので、安心してください。

---

## GitHubアカウントとリポジトリを作る

### アカウント作成

GitHubのアカウントを持っていない場合は、[GitHub](https://github.com/) で作成してください（無料）。ユーザー名は**サイトのURLの一部になる**ので、公開しても恥ずかしくない名前にしましょう。

### リポジトリ作成

GitHubにログインして、新しいリポジトリ（コードの置き場所）を作ります。

1. 右上の「+」→「New repository」を選ぶ
2. **Repository name** に `あなたのユーザー名.github.io` と入力する（例：ユーザー名が `yamada-taro` なら `yamada-taro.github.io`）
3. **Public** を選ぶ
4. 「Create repository」を押す

:::message
リポジトリ名を `ユーザー名.github.io` にすると、サイトのURLがそのまま `https://ユーザー名.github.io/` になります。これはGitHub Pagesの特別ルールで、1アカウントに1つだけ作れる「自分のメインサイト用」のリポジトリ名です。

別の名前（例：`my-astro-site`）でも公開できますが、URLが `https://ユーザー名.github.io/my-astro-site/` のようになり、サイト内のリンクの書き方に追加の設定（`base` 設定）が必要になります。このチュートリアルでは、シンプルに済む `ユーザー名.github.io` 方式で説明を進めます。

すでに `ユーザー名.github.io` を別のサイトで使っている場合など、どうしても別の名前にしたいときは、この章の最後の「補足：リポジトリ名を `ユーザー名.github.io` 以外にした場合」で手順をまとめています。先にそちらを読んでから進めてください。
:::

### `site` 設定を確認する

前の章で `astro.config.mjs` に設定した `site` が、実際のURLと一致しているか確認してください。

```js:astro.config.mjs（確認）
export default defineConfig({
  site: 'https://あなたのユーザー名.github.io',
  integrations: [sitemap()],
});
```

---

## デプロイ用のワークフローを作る

**GitHub Actions**は、GitHub上で自動的に処理を実行してくれる仕組みです。「pushされたらAstroをビルドしてGitHub Pagesに公開する」という手順書（**ワークフロー**）をファイルで用意します。

プロジェクトの一番上（`src/` と同じ階層）に `.github/workflows/` というフォルダを作り、`deploy.yml` を作成してください。

```yaml:.github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout your repository
        uses: actions/checkout@v4
      - name: Install, build, and upload your site
        uses: withastro/action@v6

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

:::message alert
YAMLファイルは**インデント（字下げ）が意味を持つ**形式です。上のコードをそのままコピーして、字下げを変えないように注意してください。
:::

内容をすべて理解する必要はありませんが、大まかにはこう書いてあります。

- `on: push: branches: [main]`：mainブランチにpushされたら実行する
- `build`：Astro公式のアクション（`withastro/action`）でサイトをビルドする
- `deploy`：ビルド結果をGitHub Pagesに公開する

---

## GitHubにpushする

プロジェクト作成時にGitリポジトリを作ってあるので（第1章で「Initialize a new git repository?」にYesと答えました）、ここまでの変更をコミットして、GitHubにpushします。

ターミナルで、プロジェクトのフォルダにいることを確認して次を実行してください。`あなたのユーザー名` は自分のものに置き換えます。

```bash
git add .
git commit -m "サイト完成"
git branch -M main
git remote add origin https://github.com/あなたのユーザー名/あなたのユーザー名.github.io.git
git push -u origin main
```

各コマンドの意味は次のとおりです。

| コマンド | 意味 |
|---|---|
| `git add .` | すべての変更を記録対象にする |
| `git commit -m "..."` | 変更をひとまとまりとして記録する |
| `git branch -M main` | ブランチ名をmainにする |
| `git remote add origin ...` | アップロード先のGitHubリポジトリを登録する |
| `git push -u origin main` | GitHubにアップロードする |

:::message
初めてpushするときは、GitHubへのログイン（認証）を求められることがあります。画面の指示に従ってブラウザで認証してください。
:::

---

## GitHub Pagesの設定をする

最後に、GitHubのリポジトリ側で「GitHub Actionsで公開する」設定をします。

1. GitHubのリポジトリページを開く
2. 「Settings」タブ →左メニューの「Pages」を開く
3. 「Build and deployment」の「Source」を **GitHub Actions** に変更する

設定後、リポジトリの「Actions」タブを開いてみてください。「Deploy to GitHub Pages」というワークフローが動いている（または完了している）はずです。緑のチェックマークがつけば公開完了です。

:::message
Sourceの設定より先にpushした場合、最初のワークフローが失敗していることがあります。その場合は「Actions」タブから失敗したワークフローを開き、「Re-run all jobs」で再実行してください。
:::

---

## 公開されたサイトを確認する

ブラウザで `https://あなたのユーザー名.github.io/` を開いてください。

あなたのサイトがインターネットに公開されました！ スマートフォンからも、友だちのパソコンからも、世界中どこからでも見られます。

ぜひ確認してみてください。

- トップページ、プロフィール、ブログ、タグページがすべて動くか
- ダークモード切り替えが動くか
- スマートフォンで見たときの表示
- `https://あなたのユーザー名.github.io/rss.xml`（RSSフィード）

---

## 補足：リポジトリ名を `ユーザー名.github.io` 以外にした場合

ここまでは、リポジトリ名を `ユーザー名.github.io` にした場合の手順でした。`my-astro-site` のような別の名前でリポジトリを作った場合は、この節の設定を追加してください。設定を飛ばすと、サイトは表示されるものの**CSSが当たらない・リンクを押すと404になる**という状態になります。

以下、リポジトリ名を `my-astro-site` として説明します。自分のリポジトリ名に読み替えてください。

### なぜ設定が必要なのか

リポジトリ名が `my-astro-site` のとき、公開されるサイトのURLは次のようになります。

```
https://あなたのユーザー名.github.io/my-astro-site/
```

つまり、**サイトのトップページが `/` ではなく `/my-astro-site/` になる**わけです。ところが、ここまで書いてきたリンクは `/blog/` や `/tags/` のように「`/`（サイトの一番上）から始まるパス」でした。この書き方のままだと、ブログ一覧へのリンクは `https://あなたのユーザー名.github.io/blog/` を指してしまい、そんなページは存在しないので404になります。

対策は、サイト内のリンクすべてに `/my-astro-site` を足すことです。とはいえ、全ファイルに手で書き足すのは大変ですし、リポジトリ名を変えたときにまた全部直すことになります。そこで次の2段構えにします。

1. `astro.config.mjs` の `base` に「サイトが置かれる場所」を設定する
2. リンクを組み立てる小さな関数 `url()` を用意し、サイト内リンクはすべてそれを通す

こうしておけば、リポジトリ名が変わっても直すのは `base` の1行だけで済みます。

### 手順1：`base` を設定する

`astro.config.mjs` に `base` を追加します。

```js:astro.config.mjs
// @ts-check
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://あなたのユーザー名.github.io',
  base: '/my-astro-site/',
  integrations: [sitemap()],
});
```

:::message alert
`site` と `base` は役割が違います。`site` は**ドメインまで**（`https://ユーザー名.github.io`）、`base` は**その下のフォルダ部分**（`/my-astro-site/`）です。`site` に `https://ユーザー名.github.io/my-astro-site` とまとめて書いてしまうのはよくある間違いで、サイトマップやRSSのURLがおかしくなります。
:::

### 手順2：リンクを組み立てる関数を用意する

`src/consts.ts` に `url()` という関数を追加し、`NAV_ITEMS` のリンクもこの関数を通すように書き換えます。

```ts:src/consts.ts
export const SITE = {
  title: "わたしのサイト",
  description: "趣味と日々の記録を綴る個人サイトです。",
  author: "わかばやし",
} as const;

/**
 * サイト内リンクのURLを組み立てます。
 * astro.config.mjs の base 設定を先頭に付けるので、
 * ルート公開（/）でもサブディレクトリ公開（/my-astro-site/）でも
 * 同じ書き方のまま正しいURLになります。
 */
export function url(path: string) {
  const base = import.meta.env.BASE_URL.replace(/\/$/, "");
  return `${base}/${path.replace(/^\//, "")}`;
}

export const NAV_ITEMS = [
  { label: "ホーム", href: url("/") },
  { label: "ブログ", href: url("/blog/") },
  { label: "タグ", href: url("/tags/") },
  { label: "プロフィール", href: url("/about/") },
] as const;
```

`import.meta.env.BASE_URL` には、`astro.config.mjs` に書いた `base` の値がそのまま入ります。関数の中でやっているのは、スラッシュが重ならないように前後を整えて、`base` とパスをつなげることだけです。`url("/blog/")` は `/my-astro-site/blog/` を返します。

:::message
`base` を設定していないサイトでは `BASE_URL` は `/` になるので、`url("/blog/")` は `/blog/` を返します。つまり、この関数を通しておけば**どちらの公開方法でもそのまま動きます**。
:::

### 手順3：サイト内リンクを `url()` 経由にする

`/` から始まるリンクを書いた箇所を、すべて `url()` 経由に書き換えます。対象は次の7ファイルです。

| ファイル | 書き換える箇所 |
|---|---|
| `src/components/Header.astro` | サイトタイトルのリンク |
| `src/pages/blog/index.astro` | 各記事へのリンク |
| `src/pages/blog/[id].astro` | タグへのリンク、記事一覧に戻るリンク |
| `src/pages/tags/index.astro` | 各タグへのリンク |
| `src/pages/tags/[tag].astro` | 各記事へのリンク、タグ一覧に戻るリンク |
| `src/pages/404.astro` | トップページに戻るリンク |
| `src/pages/rss.xml.js` | フィードのURLと記事のリンク（手順4で説明します） |

書き換えのパターンは1つだけです。`href` の中身をまるごと `url()` で包みます。

```diff html:書き換えの例
- <a href="/blog/">← 記事一覧にもどる</a>
+ <a href={url("/blog/")}>← 記事一覧にもどる</a>

- <a href={`/blog/${post.id}/`}>{post.data.title}</a>
+ <a href={url(`/blog/${post.id}/`)}>{post.data.title}</a>
```

`"/blog/"` のようにダブルクォートで書いていたリンクは、`{url("/blog/")}` と**波かっこ**に変わる点に注意してください。JavaScriptの関数を呼ぶので、波かっこが必要です。

そして、各ファイルの先頭（`---` で囲まれた部分）に `url` の読み込みを追加します。すでに `SITE` や `NAV_ITEMS` を読み込んでいるファイルは、そこに `url` を足すだけです。

```html:src/components/Header.astro（先頭部分）
---
import { SITE, NAV_ITEMS, url } from "../consts";
---
```

`src/pages/blog/` や `src/pages/tags/` の中のファイルは1階層深いので、パスは `"../../consts"` になります。

### 手順4：RSSとサイトマップを整える

RSSフィードは「絶対URL」（`https://` から始まる完全なURL）を書き出すので、こちらも `base` を含める必要があります。`src/pages/rss.xml.js` を次のように直します。

```js:src/pages/rss.xml.js
import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { SITE, url } from '../consts';

export async function GET(context) {
  const posts = await getCollection('blog');
  const sortedPosts = posts.sort(
    (a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime()
  );

  return rss({
    title: SITE.title,
    description: SITE.description,
    site: new URL(import.meta.env.BASE_URL, context.site),
    items: sortedPosts.map((post) => ({
      title: post.data.title,
      pubDate: post.data.pubDate,
      description: post.data.description,
      link: url(`/blog/${post.id}/`),
    })),
  });
}
```

`context.site` には `astro.config.mjs` の `site`（ドメインまで）が入るので、そこに `base` をつないで「サイトのトップ」を作っています。

前の章で `BaseLayout.astro` の `<head>` に追記した、RSSの場所を知らせる1行も直します。

```diff html:src/layouts/BaseLayout.astro（head内）
- <link rel="alternate" type="application/rss+xml" title={SITE.title} href={new URL('rss.xml', Astro.site)} />
+ <link rel="alternate" type="application/rss+xml" title={SITE.title} href={new URL(url('/rss.xml'), Astro.site)} />
```

こちらも先頭の読み込みを `import { SITE, url } from "../consts";` に変えておいてください。

サイトマップ（`@astrojs/sitemap`）は `base` を自動で考慮するので、**手を入れる必要はありません**。同じように、`<Image />` で表示している画像や、記事のMarkdown内で相対パス（`./images/river.jpg`）で書いた画像、CSSの読み込みもAstroが自動で `base` を付けてくれます。手で直すのは、自分で `/` から書いたリンクだけです。

### 手順5：手元で確認する

`base` を設定すると、**開発サーバーのURLも変わります**。

```bash
npm run dev
```

`http://localhost:4321/` を開くと404になります。`http://localhost:4321/my-astro-site/` を開いてください。これは設定が効いている証拠なので、あわてなくて大丈夫です。

トップページ・ブログ一覧・記事・タグページ・404ページを一通り開いて、リンクがすべてつながることを確認します。うまくいっていないリンクがあれば、そのリンクが `url()` を通っていないはずです。

ビルドした結果を確かめるなら、次のコマンドでも確認できます。

```bash
npm run build
npm run preview
```

こちらも `http://localhost:4321/my-astro-site/` で開きます。

### 手順6：公開する

ここから先は本編と同じですが、pushするときのリポジトリのURLだけ変わります。

```bash
git remote add origin https://github.com/あなたのユーザー名/my-astro-site.git
```

GitHub Pagesの設定（Settings → Pages → SourceをGitHub Actionsにする）も、ワークフローのファイルも本編と同じです。公開後は `https://あなたのユーザー名.github.io/my-astro-site/` でサイトを確認できます。

:::message
リポジトリ名を後から変更した場合は、`astro.config.mjs` の `base` も忘れずに書き換えてください。逆にいえば、`url()` を使っておけば直すのはそこだけです。
:::

---

## これからの更新の流れ

今後、サイトを更新する手順はとてもシンプルです。

1. 記事を書く／コードを直す
2. `npm run dev` で手元で確認する
3. 変更をコミットしてpushする

```bash
git add .
git commit -m "記事を追加"
git push
```

pushすると、GitHub Actionsが自動でビルドして数分以内にサイトが更新されます。**記事を書いてpushするだけ**の運用です。

---

## まとめ

- `ユーザー名.github.io` という名前のリポジトリを作ると、`https://ユーザー名.github.io/` で公開できます
- `.github/workflows/deploy.yml` に、Astro公式アクションを使ったワークフローを用意しました
- リポジトリのSettings → PagesでSourceを「GitHub Actions」にしました
- 以降は**pushするだけでサイトが自動更新**されます
- リポジトリ名を別の名前にした場合は、`base` の設定と `url()` によるリンクの組み立てが必要です（章末の補足）

次の章では、GitHub Pagesを使わずに、ビルドしたファイルを自分のサーバーに置いて公開する方法を紹介します。GitHub Pagesで公開できた方は読み飛ばして、最終章に進んでもかまいません。
