---
title: サイト全体のスタイリング
---

## Astroの2種類のスタイル

ここまでのスタイルは、各コンポーネントの `<style>` タグに書いてきました。この章では、サイト全体のデザインを整えるために、Astroの2種類のスタイルを使い分けます。

| 種類 | 書く場所 | 効く範囲 | 用途 |
|---|---|---|---|
| スコープ付きスタイル | 各 `.astro` の `<style>` | そのコンポーネントの中だけ | 部品ごとの見た目 |
| グローバルスタイル | `src/styles/global.css` | サイト全体 | 色・フォント・余白の基本ルール |

**基本方針は「スタイルはコンポーネントに閉じる」**です。グローバルスタイルには、サイト全体の土台となるルールだけを書きます。

---

## グローバルスタイルを作る

`src/styles/` フォルダを作り、`global.css` を作成してください。

```css:src/styles/global.css
/* ===== デザイントークン（サイト全体で使う値） ===== */
:root {
  --color-bg: #ffffff;
  --color-text: #1f2328;
  --color-text-weak: #57606a;
  --color-accent: #2da44e;
  --color-border: #d0d7de;
  --color-surface: #f6f8fa;

  --font-body: "Hiragino Kaku Gothic ProN", "Hiragino Sans", "Yu Gothic",
    "Noto Sans JP", sans-serif;

  --content-width: 720px;
}

/* ===== リセットと基本設定 ===== */
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: var(--font-body);
  background-color: var(--color-bg);
  color: var(--color-text);
  line-height: 1.8;
}

a {
  color: var(--color-accent);
}

h1,
h2,
h3 {
  line-height: 1.4;
}

/* ===== コンテンツ幅 ===== */
main {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 2rem 1rem;
}
```

### デザイントークンとは

`:root` の中に書いた `--color-bg` のような変数を**CSS変数（カスタムプロパティ）** と呼びます。サイトで使う色やフォントを変数として1か所にまとめておき、各所では `var(--color-bg)` のように参照します。

こうしておくと、次のようなメリットがあります。

- サイトのテーマカラーを変えたいとき、変数の値を1行変えるだけで全体に反映される
- 「この場所の色だけ微妙に違う」といったバラつきを防げる
- あとでダークモード（第11章）を作るときに、変数の値を切り替えるだけで済む

`consts.ts` にサイト情報をまとめたのと同じ発想で、**デザインの決めごとも1か所にまとめる**わけです。

---

## グローバルスタイルを読み込む

`global.css` は、`BaseLayout.astro` のコンポーネントスクリプトでimportします。全ページがこのレイアウトを使うので、これだけで全ページに適用されます。

```html:src/layouts/BaseLayout.astro
---
import '../styles/global.css';
import { SITE } from '../consts';
import Header from '../components/Header.astro';
import Footer from '../components/Footer.astro';

interface Props {
  title?: string;
  description?: string;
}

const { title, description = SITE.description } = Astro.props;
const pageTitle = title ? `${title} | ${SITE.title}` : SITE.title;
---
```

（テンプレート部分は変更ありません。1行目の `import '../styles/global.css';` を追加しただけです）

保存すると、フォントや行間が変わり、コンテンツが中央寄せになったはずです。

---

## コンポーネントのスタイルをトークンで整える

各コンポーネントの `<style>` に直接書いていた色（`#ccc` など）を、CSS変数に置き換えていきます。コンポーネントのスコープ付きスタイルの中からも、グローバルに定義したCSS変数は参照できます。

**`src/components/Header.astro`** は、テンプレートとスタイルの両方を変更します。

まず、ヘッダーの中身を `header-wrapper` というdivで包みます。罫線は画面の端まで引き、中身だけをコンテンツ幅に揃えたいからです。テンプレート部分を次のようにしてください。

```html:src/components/Header.astro（テンプレート部分）
<div class="header-wrapper">
  <header>
    <a href="/" class="site-title">{SITE.title}</a>
    <nav>
      <ul>
        {NAV_ITEMS.map((item) => (
          <li><a href={item.href}>{item.label}</a></li>
        ))}
      </ul>
    </nav>
  </header>
</div>
```

続いて `<style>` を次のように変更します。色をCSS変数に置き換えるとともに、罫線をいま追加した `.header-wrapper` に移しています。

```html
<style>
  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: var(--content-width);
    margin: 0 auto;
    padding: 1rem;
  }
  .header-wrapper {
    border-bottom: 1px solid var(--color-border);
  }
  .site-title {
    font-weight: bold;
    font-size: 1.1rem;
    text-decoration: none;
    color: inherit;
  }
  ul {
    display: flex;
    gap: 1rem;
    list-style: none;
    margin: 0;
    padding: 0;
  }
  nav a {
    text-decoration: none;
    color: inherit;
  }
  nav a:hover {
    color: var(--color-accent);
  }
</style>
```

**`src/components/Footer.astro`** の `<style>` も変数に置き換えます。

```html
<style>
  footer {
    margin-top: 4rem;
    padding: 2rem 1rem;
    border-top: 1px solid var(--color-border);
    text-align: center;
    font-size: 0.9rem;
    color: var(--color-text-weak);
  }
</style>
```

**`src/components/Card.astro`** も整えましょう。

```html
<style>
  .card {
    border: 1px solid var(--color-border);
    border-radius: 8px;
    padding: 1rem 1.25rem;
    background-color: var(--color-surface);
  }
  .card h2 {
    margin: 0 0 0.5rem;
    font-size: 1.1rem;
  }
  .card p {
    margin: 0;
    color: var(--color-text-weak);
  }
</style>
```

保存してブラウザを確認すると、統一感のあるデザインになりました。

:::message
色の値（`#2da44e` など）は好みに合わせて変更してかまいません。CSS変数にまとめてあるので、`global.css` の `:root` を編集するだけでサイト全体の配色が変わります。自分好みのテーマカラーを試してみてください。
:::

---

## スタイルをどこに書くか迷ったら

| 迷ったとき | 答え |
|---|---|
| この部品だけの見た目 | その `.astro` の `<style>` に書く |
| サイト全体の色・フォント・余白のルール | `global.css` のCSS変数・基本設定に書く |
| 複数の部品で同じ色を使いたい | CSS変数を定義して両方から `var()` で参照する |

「グローバルにすべてのスタイルを書く」のはアンチパターンです。グローバルは土台だけ、装飾は各コンポーネントへ——この役割分担を守ると、サイトが大きくなってもスタイルが壊れにくくなります。

---

## まとめ

- スタイルには「コンポーネントに閉じるスコープ付きスタイル」と「サイト全体のグローバルスタイル」の2種類があります
- 色やフォントは**CSS変数（デザイントークン）** として `global.css` の `:root` に集約しました
- グローバルCSSは `BaseLayout.astro` でimportして全ページに適用します
- コンポーネントのスタイルからもCSS変数を参照できます

次の章では、いよいよブログ機能の土台となる「Content Collections」を導入します。
