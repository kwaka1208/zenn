---
title: 動きをつける：ダークモード切り替え
---

## ここまでJavaScriptを1行も送っていない

実は、ここまで作ったサイトは**訪問者のブラウザでJavaScriptを一切実行していません**。`.astro` のコンポーネントスクリプトはすべてビルド時に実行され、ブラウザに届くのは完成済みのHTMLとCSSだけです。これがAstroのサイトが速い理由です。

とはいえ、「ボタンを押したら何かが起きる」仕組みが必要になることもあります。この章では、**ダークモード切り替えボタン**を作りながら、Astroでブラウザ側の動きを実装する方法を学びます。

---

## ダークモードの配色を用意する

第5章でデザイントークン（CSS変数）を導入した効果が、ここで最大限に発揮されます。**変数の値を暗い配色に差し替えるだけ**でダークモードが作れるのです。

`src/styles/global.css` の `:root` ブロックの下に、次を追記してください。

```css:src/styles/global.css（追記）
:root.dark {
  --color-bg: #0d1117;
  --color-text: #e6edf3;
  --color-text-weak: #9198a1;
  --color-accent: #3fb950;
  --color-border: #3d444d;
  --color-surface: #161b22;
}
```

`:root.dark` は「`<html>` タグに `dark` というclassがついているとき」という意味です。つまり、**`<html>` のclassを付け外しするだけで、サイト全体の配色が切り替わります**。各コンポーネントはすべて `var(--color-〇〇)` で色を参照しているので、1か所も修正する必要がありません。

試しに、ブラウザの開発者ツールで `<html>` タグに `class="dark"` を手で追加してみてください。サイト全体が一瞬でダークモードになります。

---

## 切り替えボタンを作る

次に、このclassをボタンで切り替えられるようにします。`src/components/Header.astro` のナビゲーションの隣にボタンを追加します。

```html:src/components/Header.astro（テンプレート部分）
<div class="header-wrapper">
  <header>
    <a href="/" class="site-title">{SITE.title}</a>
    <div class="header-right">
      <nav>
        <ul>
          {NAV_ITEMS.map((item) => (
            <li><a href={item.href}>{item.label}</a></li>
          ))}
        </ul>
      </nav>
      <button id="theme-toggle" aria-label="ダークモード切り替え">🌙</button>
    </div>
  </header>
</div>

<script>
  const button = document.getElementById('theme-toggle');

  button?.addEventListener('click', () => {
    const isDark = document.documentElement.classList.toggle('dark');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
  });
</script>
```

`<style>` には次を追記してください。

```css
.header-right {
  display: flex;
  align-items: center;
  gap: 1rem;
}
#theme-toggle {
  border: 1px solid var(--color-border);
  background: none;
  border-radius: 6px;
  padding: 0.25rem 0.5rem;
  cursor: pointer;
  font-size: 1rem;
}
```

保存してボタンを押すと、サイトがダークモードに切り替わります。もう一度押すと戻ります。

### `<script>` タグ：ブラウザで動くJavaScript

ここで初めて登場したのが、テンプレート内の **`<script>` タグ**です。

| 書く場所 | 実行される場所とタイミング |
|---|---|
| `---` の間（コンポーネントスクリプト） | **ビルド時**に一度だけ。ブラウザでは動かない |
| テンプレート内の `<script>` | **訪問者のブラウザ**で動く |

「ボタンを押したら」のようなブラウザ上の動きは、必ず `<script>` タグに書きます。コードの中身は普通のJavaScriptです。

- `document.getElementById('theme-toggle')` でボタンの要素を取得します
- `addEventListener('click', ...)` で「クリックされたときの処理」を登録します
- `classList.toggle('dark')` は「`dark` classがなければ付け、あれば外す」で、付けた後の状態を `true/false` で返します
- `button?.` の `?` は「ボタンが見つからなかったら何もしない」という安全のための書き方です

### 選んだ設定を覚えておく：`localStorage`

```ts
localStorage.setItem('theme', isDark ? 'dark' : 'light');
```

`localStorage`（ローカルストレージ）は、**ブラウザにデータを保存しておける仕組み**です。ページを閉じても消えません。ここでは「訪問者が選んだテーマ」を保存しています。

ただし、保存しただけではまだ意味がありません。次にページを開いたときに**読み出して適用する**処理が必要です。

---

## ページを開いたときに設定を復元する

保存したテーマ設定を、ページ読み込み時に適用します。この処理は `src/layouts/BaseLayout.astro` の `<head>` 内に書きます。

```html:src/layouts/BaseLayout.astro（head内に追記）
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content={description} />
  <title>{pageTitle}</title>

  <script is:inline>
    if (localStorage.getItem('theme') === 'dark') {
      document.documentElement.classList.add('dark');
    }
  </script>
</head>
```

### `is:inline`：ちらつきを防ぐための特別指定

`<script is:inline>` という見慣れない書き方をしました。

Astroは通常、`<script>` タグの中身をまとめて最適化し、**ページの表示後に**読み込みます。ほとんどの場合はそれで良いのですが、テーマの復元だけは事情が違います。ページが白い背景で表示された後にダークモードが適用されると、一瞬白く光ってから暗くなる「ちらつき」が起きてしまうのです。

`is:inline` は「このスクリプトは最適化せず、この位置でそのまま実行して」という指定です。`<head>` 内で**ページが描画される前に**実行されるため、最初から暗い背景で表示され、ちらつきが起きません。

:::message
「基本は普通の `<script>`、描画前にどうしても実行したい数行だけ `is:inline`」という使い分けです。`is:inline` のスクリプトは最適化の対象外になるので、多用は禁物です。
:::

動作を確認しましょう。ダークモードに切り替えてからページを再読み込みしても、ダークモードのまま表示されれば成功です。

---

## アイランドアーキテクチャ：Astroの設計思想

この章で書いたJavaScriptは、ダークモード切り替えのわずか数行だけです。ページの大部分は静的なHTMLのまま、**動きが必要な小さな部分だけ**にJavaScriptを使いました。

Astroではこの考え方を**アイランドアーキテクチャ（島の設計）** と呼びます。静的なHTMLの海の中に、JavaScriptで動く小さな「島」が浮かんでいるイメージです。

### 島を作る2つの方法

| 方法 | 使いどころ |
|---|---|
| `<script>` タグ | トグル、タブ、メニューの開閉など、**軽い動き**（今回のダークモードもこれ） |
| ReactなどのUIフレームワーク | 状態管理が複雑な本格的アプリ部品（検索UI、ゲームなど） |

AstroはReact・Vue・Svelteなどのコンポーネントをページに埋め込むこともできます。ただし、それは「`<script>` タグでは大変なほど複雑な島」がある場合の話です。**まず `<script>` タグで足りないか考える**のがAstro流です。

:::message
「じゃあ全部Reactで書けば楽では？」と思うかもしれませんが、フレームワークの島はその分JavaScriptをブラウザに送ります。島を増やすほどAstroの速さという長所が失われていきます。「本当にJavaScriptが必要か？」を常に問いかけるのが、Astroとの上手な付き合い方です。
:::

---

## まとめ

- ブラウザで動く処理は、テンプレート内の `<script>` タグに書きます
- CSS変数で配色を管理していたおかげで、ダークモードは「classの付け外し」だけで実現できました
- `localStorage` で訪問者の設定を保存し、`<head>` 内の `is:inline` スクリプトでちらつきなく復元しました
- Astroは「静的なHTML＋必要な部分だけJavaScriptの島」という**アイランドアーキテクチャ**で作られています

次の章では、404ページ・サイトマップ・RSSフィードを整えて、公開の準備をします。
