---
title: 画像の表示と最適化
---

## Webサイトと画像の悩ましい関係

プロフィールサイトに写真を載せたくなりました。でも、スマートフォンで撮った写真をそのまま載せると、1枚で数MBもあり、ページの表示が一気に遅くなります。

かといって、載せる前に毎回手作業でリサイズ・圧縮するのは面倒です。Astroには、この問題を自動で解決してくれる**画像最適化**の仕組み（`astro:assets`）が組み込まれています。

---

## 画像を置く場所は2つある

Astroでは、画像の置き場所によって扱いが変わります。

| 置き場所 | 扱い | 使いどころ |
|---|---|---|
| `src/assets/` | **ビルド時に最適化される** | 写真・イラストなど、ページに表示する画像 |
| `public/` | そのまま配信される（最適化なし） | favicon、加工されては困るファイル |

**基本は `src/assets/`** です。`public/` に画像を置くのは、最適化してほしくない特別なファイルだけと覚えてください。

---

## プロフィール画像を表示する

プロフィールページに画像を載せてみましょう。

1. `src/assets/` フォルダを作る
2. 自分の写真やアイコン画像を `profile.jpg` という名前で置く（お持ちの好きな画像でかまいません。PNGなら `profile.png` にして、以降のコードも合わせてください）

`src/pages/about.astro` を次のように変更します。

```html:src/pages/about.astro（変更部分）
---
import BaseLayout from '../layouts/BaseLayout.astro';
import { Image } from 'astro:assets';
import { SITE } from '../consts';
import profileImage from '../assets/profile.jpg';

const skills = [
  { name: "写真", level: "一眼レフ歴5年" },
  { name: "文章を書くこと", level: "ブログ歴3年" },
  { name: "コーヒーの淹れ方", level: "ハンドドリップ修行中" },
];
---

<BaseLayout title="プロフィール" description="このサイトの運営者の自己紹介ページです。">
  <h1>プロフィール</h1>

  <section class="intro">
    <Image src={profileImage} alt={`${SITE.author}のプロフィール写真`} width={160} class="profile-image" />
    <div>
      <h2>{SITE.author}について</h2>
      <p>
        はじめまして、{SITE.author}です。
        週末はカメラを持って出かけることが多く、撮った写真や訪れた場所のことをこのサイトに記録しています。
      </p>
    </div>
  </section>
```

（「できること・やっていること」のセクション以降は、第4章に書いたままで変更ありません）

`<style>` には次を追記します。

```css
.intro {
  display: flex;
  gap: 1.5rem;
  align-items: flex-start;
}
.profile-image {
  border-radius: 50%;
  flex-shrink: 0;
}
```

注目してほしいのは3つです。

### 画像はimportして使う

```ts
import profileImage from '../assets/profile.jpg';
```

`src/assets/` の画像は、コンポーネントと同じように**importして**使います。「ファイルパスを文字列で書く」のではなくimportすることで、Astroがビルド時にその画像を見つけて最適化できるようになります。ファイル名の打ち間違いがあればビルド時にエラーで気づけるのも利点です。

### `<img>` ではなく `<Image />` を使う

```html
<Image src={profileImage} alt="..." width={160} />
```

`astro:assets` からimportした `<Image />` コンポーネントを使うと、Astroがビルド時に次の処理を自動で行います。

- 指定した幅に合わせた**リサイズ**
- **WebP**（軽量な画像形式）への変換
- 幅・高さ属性の自動付与（読み込み中のレイアウトのガタつき防止）
- 画面外の画像の**遅延読み込み**（スクロールして近づいてから読み込む）

数MBの写真を置いても、実際に配信されるのは数十KBの最適化済み画像になります。

### `alt`：画像の説明文

`alt` は、画像を見られない状況（読み上げソフトの利用、通信エラーなど）で代わりに使われる説明文です。省略するとエラーになります。「何の画像なのか」を言葉で書いてください。

ブラウザで `/about/` を確認すると、丸くトリミングされたプロフィール画像が表示されます。

:::message
本当にWebPに変換されているのか確かめたい方は、**開発者ツール**（ブラウザに標準で備わっている、表示中のページの中身を調べる機能）で確認できます。画像を右クリックして「検証」を選ぶか、`F12` キー（Macは `Cmd + Option + I`）を押すと開きます。表示された `<img>` タグの `src` が `.webp` で終わっていれば、変換されています。
:::

---

## トップページにも載せる

トップページの冒頭にも、あいさつ代わりに同じ画像を小さく載せてみましょう。`src/pages/index.astro` の冒頭部分を変更します。

```html:src/pages/index.astro（変更部分）
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Card from '../components/Card.astro';
import { Image } from 'astro:assets';
import { SITE } from '../consts';
import profileImage from '../assets/profile.jpg';

const hobbies = [
  { title: "カメラ", description: "週末に風景写真を撮っています。" },
  { title: "登山", description: "低山めぐりが好きです。" },
  { title: "コーヒー", description: "自宅で豆を挽いています。" },
];
---

<BaseLayout>
  <div class="hero">
    <Image src={profileImage} alt={`${SITE.author}のアイコン`} width={80} class="hero-image" loading="eager" />
    <div>
      <h1>ようこそ！</h1>
      <p>このサイトでは、趣味のことや日々の記録を発信しています。</p>
    </div>
  </div>
```

`<style>` に追記します。

```css
.hero {
  display: flex;
  gap: 1rem;
  align-items: center;
}
.hero-image {
  border-radius: 50%;
}
```

### `loading="eager"`：最初に見える画像だけの特別扱い

`<Image />` は通常、遅延読み込み（lazy loading）になります。しかし、**ページを開いた瞬間に見える位置にある画像**は、遅延させるとかえって表示が遅く感じられます。そこで `loading="eager"`（すぐ読み込む）を指定します。

| 画像の位置 | 指定 |
|---|---|
| ページを開いてすぐ見える（ファーストビュー） | `loading="eager"` |
| スクロールしないと見えない | 指定なし（デフォルトの遅延読み込み） |

同じ画像ファイルから `width={160}` と `width={80}` の2種類の最適化画像が作られている点にも注目してください。元画像は1枚でも、使う場面に応じたサイズが自動で用意されます。

---

## ブログ記事の中に画像を入れる

Markdownの記事に画像を入れる場合は、もっと簡単です。記事と同じフォルダ（または近く）に画像を置いて、Markdownの画像記法で**相対パス**を書くだけです。

```
src/content/blog/
├── camera-walk.md
└── images/
    └── river.jpg
```

```md:src/content/blog/camera-walk.md（本文に追記）
## 今日の一枚

![川沿いで撮ったサギの写真](./images/river.jpg)

サギが魚を狙ってじっと立っている姿を撮れました。
```

相対パス（`./images/river.jpg`）で書かれた記事内の画像も、Astroが自動で最適化してくれます。`<Image />` を書く必要はありません。

:::message
手元に適当な画像がない場合、この節は読むだけで先に進んでも大丈夫です。あとから記事に画像を足したくなったときに戻ってきてください。
:::

---

## まとめ

- ページで使う画像は `src/assets/` に置き、**importして `<Image />` で表示**します
- `<Image />` はリサイズ・WebP変換・遅延読み込みを自動で行います
- ページを開いてすぐ見える画像には `loading="eager"` を指定します
- Markdown記事内の画像は、相対パスで書けば自動で最適化されます
- `public/` に置くのはfaviconなど「最適化不要なファイル」だけです

記事が増えてくると、読みたいものを探しにくくなります。次の章ではタグ機能を作り、記事を分類できるようにします。
