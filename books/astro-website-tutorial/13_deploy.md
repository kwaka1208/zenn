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

別の名前（例：`my-astro-site`）でも公開できますが、URLが `https://ユーザー名.github.io/my-astro-site/` のようになり、サイト内のリンクの書き方に追加の設定（`base` 設定）が必要になります。このチュートリアルでは、シンプルに済む `ユーザー名.github.io` 方式を使います。
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

**あなたのサイトがインターネットに公開されました！** スマートフォンからも、友だちのパソコンからも、世界中どこからでも見られます。

ぜひ確認してみてください。

- トップページ、プロフィール、ブログ、タグページがすべて動くか
- ダークモード切り替えが動くか
- スマートフォンで見たときの表示
- `https://あなたのユーザー名.github.io/rss.xml`（RSSフィード）

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

次の章は最終章です。学んだことを振り返り、ここから先の発展の方向を紹介します。
