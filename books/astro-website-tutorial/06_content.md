---
title: ブログの土台：Content Collections
---

## ブログ記事をどう管理するか

いよいよブログ機能を作ります。まず考えたいのは「記事をどこに、どんな形式で置くか」です。

Astroには**Content Collections（コンテンツコレクション）** という、記事などのまとまったコンテンツを管理する専用の仕組みがあります。記事は**Markdown**ファイルとして書き、Astroがそれを読み込んでページに変換します。

Content Collectionsを使うと、次のようなメリットがあります。

- 記事は `src/content/` フォルダにMarkdownを置くだけ
- 記事の情報（タイトル、日付など）の**書き忘れや形式ミスをビルド時にチェック**してくれる
- 記事一覧の取得やソートが簡単にできる

---

## 記事を書いてみる

まず記事から作りましょう。`src/content/blog/` フォルダを作り、その中にMarkdownファイルを3つ作ります。

```md:src/content/blog/first-post.md
---
title: ブログをはじめました
pubDate: 2026-08-01
description: Astroで自分のサイトを作り、ブログをはじめました。
tags: [お知らせ]
---

## はじめまして

このたび、Astroで自分のサイトを作りました。

これから、趣味のことや日々の記録をここに書いていこうと思います。
どうぞよろしくお願いします。
```

```md:src/content/blog/camera-walk.md
---
title: 近所の川沿いをカメラ散歩
pubDate: 2026-08-05
description: 朝の光がきれいだったので、カメラを持って川沿いを歩いてきました。
tags: [カメラ, さんぽ]
---

## 朝の川沿いへ

早起きできた日は、カメラを持って近所の川沿いを歩くことにしています。

朝の光は柔らかくて、同じ場所でも昼間とはまったく違う表情を見せてくれます。

## 今日の一枚

サギが魚を狙ってじっと立っている姿を撮れました。
次はもう少し望遠のレンズを持って行こうと思います。
```

```md:src/content/blog/coffee-beans.md
---
title: 新しいコーヒー豆を試す
pubDate: 2026-08-10
description: 深煎りのグアテマラを買ってみたので、淹れ方を変えながら試しています。
tags: [コーヒー]
---

## 深煎りのグアテマラ

いつものお店で、今回は深煎りのグアテマラを買ってみました。

お湯の温度を少し下げて淹れると、苦味が落ち着いてチョコレートのような甘さが出てきます。

しばらくはこの豆で朝のコーヒーを楽しめそうです。
```

### frontmatter：記事につける情報

Markdownの先頭にある `---` で挟まれた部分を**frontmatter（フロントマター）** と呼びます。記事本文とは別の「記事の情報（タイトル、日付、タグなど）」を書く場所です。

:::message
Zennで記事を書いたことがある方にはおなじみの形式ですね。`.astro` ファイルの先頭の `---` は「コードを書く場所」でしたが、Markdownのfrontmatterは「設定を書く場所」です。見た目は同じ記号ですが役割が違うので注意してください。
:::

記事の内容は例なので、自分の書きたいテーマで自由に書いてかまいません。ただし、frontmatterの項目（`title`・`pubDate`・`description`・`tags`）はこのあと定義するルールに合わせてください。

---

## スキーマ：記事のルールを定義する

次に、「blogコレクションの記事はこういう情報を持つ」というルール（**スキーマ**）を定義します。`src/content.config.ts` を作ってください。

:::message alert
置き場所は `src/` の直下です。`src/content/` フォルダの中ではないので注意してください。
:::

```ts:src/content.config.ts
import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    pubDate: z.coerce.date(),
    description: z.string(),
    tags: z.array(z.string()).default([]),
  }),
});

export const collections = { blog };
```

順番に読み解いていきましょう。

### loader：どこから記事を読むか

```ts
loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
```

「`src/content/blog` フォルダの中の、すべての `.md` ファイルを記事として読み込む」という意味です。`**/*.md` の `**` は「サブフォルダも含めて」という指定です。

### schema：記事が持つべき情報

```ts
schema: z.object({
  title: z.string(),
  pubDate: z.coerce.date(),
  description: z.string(),
  tags: z.array(z.string()).default([]),
}),
```

`z` は**Zod（ゾッド）** というデータ検証ライブラリです。各行の意味は次のとおりです。

| 定義 | 意味 |
|---|---|
| `title: z.string()` | `title` は文字列。**必須** |
| `pubDate: z.coerce.date()` | `pubDate` は日付。`2026-08-01` のような文字列も日付に変換してくれる |
| `description: z.string()` | `description` は文字列。必須 |
| `tags: z.array(z.string()).default([])` | `tags` は文字列の配列。書かなければ空の配列になる |

### スキーマがあると何がうれしいのか

たとえば記事のfrontmatterで `title` を書き忘れたり、`pubDate: 明日` のような日付でない値を書いたりすると、**開発サーバーがすぐにエラーで教えてくれます**。

記事が3件のうちは目視でも確認できますが、記事が50件になったとき、全記事のfrontmatterが正しいと自信を持てるでしょうか？　スキーマは「記事が増えても壊れないブログ」のための保険です。

---

## 動作を確認する

`content.config.ts` を作成・変更したときは、開発サーバーを再起動すると確実です。ターミナルで `Ctrl + C` を押して止め、もう一度起動してください。

```bash
npm run dev
```

エラーが出なければ、記事は正しく読み込まれています。試しに、`first-post.md` の `pubDate` の行を削除して保存してみてください。次のようなエラーが表示されるはずです。

```
[InvalidContentEntryDataError] blog → first-post data does not match
collection schema.
pubDate: Required
```

「`pubDate` が必須なのにありません」と教えてくれました。確認したら、`pubDate` の行を元に戻しておいてください。

まだ記事はページとして表示されません。記事を画面に出すのは次の章で行います。

---

## ここまでのフォルダ構成

```
src/
├── components/
├── content/
│   └── blog/
│       ├── camera-walk.md
│       ├── coffee-beans.md
│       └── first-post.md
├── content.config.ts
├── consts.ts
├── layouts/
├── pages/
└── styles/
```

:::message
記事のMarkdownを `src/pages/` に直接置いてもページにはなりますが、スキーマによるチェックや一覧の取得ができません。**記事は必ずContent Collections（`src/content/`）で管理する**のがAstroの推奨スタイルです。
:::

---

## まとめ

- ブログ記事は `src/content/blog/` にMarkdownファイルとして置きます
- 記事の情報はfrontmatter（`title`・`pubDate`・`description`・`tags`）に書きます
- `src/content.config.ts` でスキーマ（記事のルール）を定義すると、記事の不備をビルド時にチェックできます

用意した記事を一覧として画面に出すのが、次の章の仕事です。
