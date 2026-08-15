---
title: ページを増やす：プロフィールページ
---

## ファイルを置けばページになる

第1章で紹介したとおり、Astroでは `src/pages/` にファイルを置くだけでページが増えます。この章では、自己紹介を載せる**プロフィールページ**を作ります。

| ファイル | URL |
|---|---|
| `src/pages/index.astro` | `/` |
| `src/pages/about.astro` | `/about` ← 今回作るページ |

---

## プロフィールページを作る

`src/pages/about.astro` を作ってください。

```html:src/pages/about.astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import { SITE } from '../consts';

const skills = [
  { name: "写真", level: "一眼レフ歴5年" },
  { name: "文章を書くこと", level: "ブログ歴3年" },
  { name: "コーヒーの淹れ方", level: "ハンドドリップ修行中" },
];
---

<BaseLayout title="プロフィール" description="このサイトの運営者の自己紹介ページです。">
  <h1>プロフィール</h1>

  <section>
    <h2>{SITE.author}について</h2>
    <p>
      はじめまして、{SITE.author}です。
      週末はカメラを持って出かけることが多く、撮った写真や訪れた場所のことをこのサイトに記録しています。
    </p>
  </section>

  <section>
    <h2>できること・やっていること</h2>
    <dl>
      {skills.map((skill) => (
        <>
          <dt>{skill.name}</dt>
          <dd>{skill.level}</dd>
        </>
      ))}
    </dl>
  </section>

  <section>
    <h2>このサイトについて</h2>
    <p>このサイトはAstroで作られています。</p>
  </section>
</BaseLayout>

<style>
  section {
    margin-bottom: 2rem;
  }
  dt {
    font-weight: bold;
  }
  dd {
    margin: 0 0 0.5rem;
    color: #555;
  }
</style>
```

内容は例なので、自分の紹介に書き換えてください。ポイントは次の3つです。

### レイアウトにPropsを渡す

```html
<BaseLayout title="プロフィール" description="このサイトの運営者の自己紹介ページです。">
```

前の章で作った `BaseLayout` は `title` と `description` を受け取れるようにしてありました。ここで渡した `title` によって、ブラウザのタブには「プロフィール | わたしのサイト」と表示されます。トップページ（`index.astro`）では何も渡していないので、サイト名だけが表示されます。

### `<> ... </>`：タグをまとめる書き方

```html
{skills.map((skill) => (
  <>
    <dt>{skill.name}</dt>
    <dd>{skill.level}</dd>
  </>
))}
```

`map()` の中で複数のタグを返したいときは、`<>` と `</>`（フラグメントと呼びます）で囲みます。「まとめるためだけの透明なタグ」で、実際のHTMLには出力されません。

### `<dl>` タグ

`<dl>`（説明リスト）は「用語（`<dt>`）と説明（`<dd>`）」のペアを並べるHTMLタグです。スキルや用語集のような「名前と説明」の組み合わせにぴったりです。

---

## ページ間を移動できることを確認する

保存したら、ブラウザで確認してみましょう。

1. `http://localhost:4321/` を開く
2. ヘッダーの「プロフィール」をクリック → `/about/` に移動する
3. ヘッダーのサイト名をクリック → トップページに戻る

前の章で `consts.ts` の `NAV_ITEMS` に `/about/` へのリンクを入れておいたので、**ヘッダーは修正なしで**新しいページに対応できています。データを1か所にまとめた効果です。

:::message
Astroのページ間リンクは、ふつうのHTMLの `<a>` タグです。ReactのSPAのような特別なリンクコンポーネントは必要ありません。「ただのHTMLのサイト」として動くのがAstroの持ち味です。
:::

---

## URLの末尾のスラッシュについて

`NAV_ITEMS` のリンクを `/about/` と末尾スラッシュ付きで書きました。Astroのデフォルト設定では `/about` でも `/about/` でも同じページが表示されますが、**サイト内の書き方はどちらかに統一**しておくと、公開後のURL移転やアクセス解析で混乱しません。このチュートリアルでは末尾スラッシュ付き（`/about/`）に統一します。

---

## まとめ

- `src/pages/about.astro` を置くだけで `/about/` ページができました
- レイアウトに `title` を渡すことで、ページごとにタイトルを変えられます
- `map()` で複数タグを返すときは `<>...</>`（フラグメント）で囲みます
- ページ間の移動はふつうの `<a>` タグで行います

次の章では、サイト全体のデザインを整えます。
