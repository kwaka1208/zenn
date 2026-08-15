---
title: 開発環境とプロジェクトの作成
---

## 必要なツールを確認する

まず、開発に必要な**Node.js**がインストールされているか確認します。

ターミナル（Macはターミナル.app、WindowsはPowerShell）を開いて、次のコマンドを入力してください。

```bash
node -v
```

Astroの動作には `v22.12.0` 以上のバージョンが必要です。

```
v22.14.0   ← このように表示されればOK
```

表示されない場合や、古いバージョンだった場合は、Node.jsをインストール（または更新）してください。手順は、別の本『開発環境構築ガイド』の「Node.js のインストール」の章で解説しています。Windows・macOS・Linuxのそれぞれについて説明しているので、お使いのOSに合わせて進めてください。

https://zenn.dev/kwaka1208/books/dev-env-setup/viewer/06_nodejs

:::message
この章では **fnm** というバージョン管理ツールを使う方法を紹介しています。バージョンの切り替えが簡単になるので、これからいろいろ試していきたい方にはおすすめです。とりあえず動けばよいという方は、[Node.js公式サイト](https://nodejs.org/ja) からLTS版をインストールしてもかまいません。
:::

---

## Astroプロジェクトを作成する

次のコマンドを実行すると、Astroプロジェクトの作成が始まります。

```bash
npm create astro@latest my-astro-site
```

`my-astro-site` の部分がプロジェクトのフォルダ名です。実行すると、いくつか質問されます。

| 質問 | 選ぶもの |
|---|---|
| How would you like to start your new project?（どのテンプレートで始めますか？） | **A basic, helpful starter project**（最小構成） |
| Install dependencies?（パッケージをインストールしますか？） | **Yes** |
| Initialize a new git repository?（Gitリポジトリを作りますか？） | **Yes** |

:::message
質問の文言や順番はバージョンによって多少変わることがあります。「テンプレートは最小構成」「インストールはYes」を選べば大丈夫です。Gitの質問は、あとで公開の章（GitHub Pages）で使うので **Yes** にしておくのがおすすめです。
:::

最小構成のテンプレートを選ぶ理由は、**あとから消す作業が少なくて済む**からです。ブログやポートフォリオのテンプレートを選ぶと、完成済みのサンプルコードが大量に入っていて、どこを直せば自分のサイトになるのかが分かりにくくなります。最小構成にも簡単なサンプル（起動直後に表示されるウェルカム画面）は入っていますが、これはすぐに自分のコードへ置き換えます。

---

## 開発サーバーを起動する

作成したプロジェクトのフォルダに移動して、開発サーバーを起動します。

```bash
cd my-astro-site
npm run dev
```

ターミナルに次のような表示が出れば起動しています。

```
 astro  v7.x.x ready in xxx ms

┃ Local    http://localhost:4321/
```

ブラウザで `http://localhost:4321/` を開くと、次のようなシンプルなページが表示されます。

![開発サーバー起動直後のトップページ](/images/astro-website-tutorial/dev-server-top.png)

「To get started, open the src/pages directory in your project.」（始めるには、プロジェクトの `src/pages` フォルダを開いてください）と書かれています。この表示はAstroのバージョンによって変わることがあります。

:::message
`4321` はAstroの開発サーバーが使うポート番号です。「4、3、2、1、発射！」というカウントダウンにちなんだ遊び心のある番号です（Astroはロケットがモチーフ）。

開発サーバーを止めたいときは、ターミナルで `Ctrl + C` を押します。
:::

---

## できあがったフォルダの中身

作成されたフォルダの中身を確認してみましょう。

```
my-astro-site/
├── node_modules/        # インストールされたパッケージ（触らない）
├── public/              # そのまま配信されるファイル（favicon等）
├── src/                 # ソースコード（ここを編集していく）
│   ├── assets/          # テンプレートに付属する画像
│   ├── components/      # 部品（ウェルカム画面用のサンプル）
│   │   └── Welcome.astro
│   ├── layouts/         # ページの共通枠（サンプル）
│   │   └── Layout.astro
│   └── pages/
│       └── index.astro  # トップページ
├── .gitignore           # Gitの管理対象外ファイルの設定
├── astro.config.mjs     # Astroの設定ファイル
├── package.json         # プロジェクトの設定・依存パッケージ一覧
├── package-lock.json    # パッケージのバージョンを固定するファイル
└── tsconfig.json        # TypeScriptの設定ファイル
```

最小構成なので、ファイルはこれだけです。このチュートリアルで主に編集するのは、**`src/` フォルダの中**です。

### `src/pages/` フォルダの特別な役割

`src/pages/` は特別なフォルダで、**この中に置いたファイルがそのままサイトのページになります**。

| ファイル | URL |
|---|---|
| `src/pages/index.astro` | `/`（トップページ） |
| `src/pages/about.astro` | `/about/` |
| `src/pages/blog/index.astro` | `/blog/` |

これを**ファイルベースルーティング**と呼びます。「ページを増やしたいときはファイルを増やす」という直感的な仕組みです。

---

## トップページを書き換えてみる

開発サーバーを起動した直後にブラウザに表示されているのは、Astroが用意しているウェルカム画面です。これを作っているのが `src/pages/index.astro` で、開くと次のような内容になっています。

```html:src/pages/index.astro
---
import Welcome from '../components/Welcome.astro';
import Layout from '../layouts/Layout.astro';

// Welcome to Astro! Wondering what to do next? Check out the Astro documentation at https://docs.astro.build
// Don't want to use any of this? Delete everything in this file, the `assets`, `components`, and `layouts` directories, and start fresh.
---

<Layout>
    <Welcome />
</Layout>
```

`Layout` と `Welcome` は、`src/layouts/` と `src/components/` に入っているサンプルの部品です。この本ではこれらを使わず、自分でページを組み立てていきます。

（テンプレートのバージョンによって中身は多少異なります）

これを次の内容に書き換えてください。

```html:src/pages/index.astro
---
---

<html lang="ja">
  <head>
    <meta charset="utf-8" />
    <title>わたしのサイト</title>
  </head>
  <body>
    <h1>わたしのサイト</h1>
    <p>ようこそ！</p>
  </body>
</html>
```

保存してブラウザを見ると、「わたしのサイト」という見出しが表示されます。

これで `Welcome.astro` と `Layout.astro` は使われなくなりますが、残しておいても表示には影響しません。気になる場合は `src/components/`・`src/layouts/`・`src/assets/` ごと削除してかまいません。

ファイルの先頭にある `---` で挟まれた部分は次の章で説明します。今は「Astroファイルの決まりごと」と思っておいてください。

### コードを変更しても画面が変わらないときは

いま体験したように、Astroにはファイルを保存すると自動的にブラウザの表示が更新される機能があります。もし変更が反映されない場合は、**ハードリロード**（キャッシュを無視した再読み込み）を試してください。

| OS | キー操作 |
|---|---|
| Mac | `Cmd + Shift + R` |
| Windows / Linux | `Ctrl + Shift + R` |

### それでも解決しないときは

環境構築は、この本の中でいちばんつまずきやすいところです。エラーメッセージが出て先に進めない場合は、コメント欄で気軽に質問してください。表示されたエラーの文面をそのまま貼っていただけると、状況がつかみやすくなります。

---

## まとめ

- `npm create astro@latest` で最小構成のAstroプロジェクトを作成しました
- `npm run dev` で開発サーバーを起動し、`http://localhost:4321/` で確認しました
- `src/pages/` に置いたファイルがそのままページになります（ファイルベースルーティング）

次の章では、Astroファイル（`.astro`）の仕組みと、部品を再利用する「コンポーネント」について学びます。
