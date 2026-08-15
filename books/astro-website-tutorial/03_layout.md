---
title: 共通レイアウトとヘッダー・フッター
---

## なぜレイアウトが必要か

前の章で作った `index.astro` には、`<html>` や `<head>` などページの骨組みも書きました。しかし、このあとページを増やしていくと、**すべてのページに同じ骨組みをコピーする**ことになってしまいます。

- サイト名を変えたくなったら全ページを修正？
- ヘッダーのデザインを変えたら全ページを修正？

これでは大変です。そこでAstroでは、ページの骨組みを**レイアウト**という共通ファイルにまとめます。

---

## サイト情報を1か所にまとめる

レイアウトを作る前に、まず「サイト名」や「説明文」のような**サイト全体で使う情報**を1か所にまとめておきましょう。`src/consts.ts` というファイルを作ってください。

```ts:src/consts.ts
export const SITE = {
  title: "わたしのサイト",
  description: "趣味と日々の記録を綴る個人サイトです。",
  author: "わかばやし",
} as const;

export const NAV_ITEMS = [
  { label: "ホーム", href: "/" },
  { label: "プロフィール", href: "/about/" },
] as const;
```

- `export` は「このデータを他のファイルから使えるようにする」という意味です
- `as const` は「この値はあとから変更しない」というTypeScriptの印です（なくても動きますが、つけておくと安全です）
- `NAV_ITEMS` はナビゲーションメニューの項目一覧です。今はまだ2つですが、章が進むと増えていきます

サイト名を変えたくなったら、このファイルを1か所直すだけで全ページに反映される——そういう状態を目指します。**同じ情報を2か所に書きそうになったら、共通化のサイン**と覚えておいてください。

---

## ベースレイアウトを作る

`src/layouts/` フォルダを作り、その中に `BaseLayout.astro` を作ってください。

```html:src/layouts/BaseLayout.astro
---
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

<html lang="ja">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content={description} />
    <title>{pageTitle}</title>
  </head>
  <body>
    <Header />
    <main>
      <slot />
    </main>
    <Footer />
  </body>
</html>
```

ポイントを順に見ていきます。

### `<slot />`：ページの中身が入る場所

**`<slot />`（スロット）** は「このレイアウトを使うページの中身が、ここに差し込まれる」という目印です。骨組み（レイアウト）と中身（各ページ）を分けるための仕組みです。

### Propsの `?` と初期値

```ts
interface Props {
  title?: string;
  description?: string;
}
```

`title?` のように `?` をつけると「渡しても渡さなくてもよいデータ」になります。

```ts
const { title, description = SITE.description } = Astro.props;
```

`description = SITE.description` は「`description` が渡されなかったら、`consts.ts` に書いたサイト説明文を使う」という初期値の指定です。

### ページタイトルの組み立て

```ts
const pageTitle = title ? `${title} | ${SITE.title}` : SITE.title;
```

これは「`title` が渡されていれば `ページ名 | サイト名`、渡されていなければサイト名だけ」という意味です。`条件 ? Aの場合 : Bの場合` という書き方（三項演算子）を使っています。

---

## ヘッダーとフッターを作る

レイアウトから読み込んでいる `Header.astro` と `Footer.astro` を作ります。

```html:src/components/Header.astro
---
import { SITE, NAV_ITEMS } from '../consts';
---

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

<style>
  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    border-bottom: 1px solid #ccc;
  }
  .site-title {
    font-weight: bold;
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
</style>
```

ナビゲーションのリンクは `consts.ts` の `NAV_ITEMS` から `map()` で作っています。**リンクをヘッダーに直接書かない**のがポイントです。あとでフッターにも同じリンクを置きたくなったとき、同じ `NAV_ITEMS` を使えば、メニューの追加が1か所の修正で済みます。

```html:src/components/Footer.astro
---
import { SITE } from '../consts';

const year = new Date().getFullYear();
---

<footer>
  <p>© {year} {SITE.author}</p>
</footer>

<style>
  footer {
    margin-top: 4rem;
    padding: 2rem 1rem;
    border-top: 1px solid #ccc;
    text-align: center;
    font-size: 0.9rem;
  }
</style>
```

`new Date().getFullYear()` で現在の年を取得しています。コンポーネントスクリプトは**ビルド時に実行される**ので、正確には「サイトをビルドした時点の年」が表示されます。年が変わったらビルドし直せば更新されます。

---

## トップページをレイアウトに乗せる

`src/pages/index.astro` を、レイアウトを使う形に書き換えます。

```html:src/pages/index.astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Card from '../components/Card.astro';

const hobbies = [
  { title: "カメラ", description: "週末に風景写真を撮っています。" },
  { title: "登山", description: "低山めぐりが好きです。" },
  { title: "コーヒー", description: "自宅で豆を挽いています。" },
];
---

<BaseLayout>
  <h1>ようこそ！</h1>
  <p>このサイトでは、趣味のことや日々の記録を発信しています。</p>

  <h2>好きなこと</h2>
  <div class="cards">
    {hobbies.map((hobby) => (
      <Card title={hobby.title} description={hobby.description} />
    ))}
  </div>
</BaseLayout>

<style>
  .cards {
    display: grid;
    gap: 1rem;
  }
</style>
```

`<html>` や `<head>` が消えてすっきりしました。`<BaseLayout>` と `</BaseLayout>` で挟んだ部分が、レイアウトの `<slot />` の位置に差し込まれます。

ブラウザで確認すると、ヘッダーとフッターのついたトップページが表示されます。ヘッダーの「プロフィール」リンクはまだ飛び先のページがないのでエラーになりますが、次の章で作るので大丈夫です。

---

## ここまでのフォルダ構成

```
src/
├── components/
│   ├── Card.astro
│   ├── Footer.astro
│   └── Header.astro
├── consts.ts
├── layouts/
│   └── BaseLayout.astro
└── pages/
    └── index.astro
```

| フォルダ | 役割 |
|---|---|
| `components/` | 再利用する部品（ヘッダー、カードなど） |
| `layouts/` | ページ全体の骨組み |
| `pages/` | 各ページ（URLに対応） |

この「部品・骨組み・ページ」の3層構成は、Astroサイトの定番の形です。

---

## まとめ

- サイト名などの共通情報は `src/consts.ts` に1か所にまとめました
- レイアウト（`BaseLayout.astro`）に `<html>` の骨組みを集約し、`<slot />` で各ページの中身を差し込みます
- ナビゲーションはデータ（`NAV_ITEMS`）として定義し、`map()` で表示します
- ページは `<BaseLayout>` で挟むだけのシンプルな形になりました

次の章では、プロフィールページを追加して、複数ページのサイトにしていきます。
