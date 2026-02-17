---
title: URL共有を爆速・綺麗にするChrome拡張「PagePick」
emoji: 📝
type: tech
topics: ["Chrome拡張機能", "生産性向上", "URL共有"]
published: false
---

## 概要

ウェブページを誰かに共有するとき、こんな悩みはありませんか？

- URL の後ろに付いている長いトラッキングパラメータ（`utm_source=...`など）を消すのが面倒
- Markdown 形式でリンクを作りたいが、ページからタイトルとURLを取り出すのが手間
- GoogleドキュメントをPDFやExcelで共有したり、コピーモードで共有したいがURLの変換が面倒、変換ルールを覚えたくない

これらをまとめて解決するために開発したのが、Chrome 拡張機能 **「PagePick」** です。

[PagePick - Chrome ウェブストア](https://chromewebstore.google.com/detail/pagepick/ffomibplfijjbilnblogaankmhnebbmp)

## できること

### 1. トラッキングパラメータの削除 & URL コピー
コピー時に、不要なパラメータ（`utm_*`, `fbclid`, `gclid` など）を自動で取り除きます。
以下の3つの形式をサポートしています：

- **TSV 形式**: `タイトル [TAB] URL`（スプレッドシートへの貼り付けに最適）
- **改行区切り 形式**: `タイトル [改行] URL`（チャット等での共有に便利）
- **Markdown 形式**: `[タイトル](URL)`（ドキュメント作成に）

### 2. Google ドキュメント / スプレッドシート / スライド のURL変換
Google Workspace（ドキュメント、スプレッドシート、スライド）には、URLの末尾（`/edit`など）を特定の文字列に書き換えるだけで、共有時の動作を変更できるという便利な隠れた仕様があります。

PagePickは、この「URLを書き換える」という手間を省力化します。編集画面で実行すると専用メニューが表示され、以下の形式のURLを即座にコピーできます。

- **強制コピーモード**: `/copy` （アクセスした人に「コピーを作成」画面を表示させます）
- **PDF でダウンロード**: `/export?format=pdf` （直接PDFファイルをダウンロードさせます）
- **Excel でダウンロード**: スプレッドシートのみ、`/export?format=xlsx` （直接Excelファイルをダウンロードさせます）

共有相手に「コピーして使ってね」と伝えたいときや、メールにPDFを添付する代わりにダウンロードURLを送りたいときに、ルールを覚える必要なくワンクリックで作成できます。

### 3. OGP 画像の抽出
現在開いているページの OGP 画像（`og:image`）をワンクリックで新しいタブに開きます。デザインの参考や、SNS 投稿の確認などに役立ちます。

## 使い方

1. [Chrome ウェブストア](https://chromewebstore.google.com/detail/pagepick/ffomibplfijjbilnblogaankmhnebbmp)からインストールします。
2. 拡張機能ボタン（パズルピースのアイコン）から PagePick を開き、ピン留めしておくと便利です。
3. 機能を使いたいページでアイコンをクリックし、メニューから実行したいアクションを選ぶだけです。

## 最後に

この拡張機能は、もともと個人的に使用していたブックマークレットを Chrome 拡張として作り直したものです。

[Bookmarklet（ブックマークレット）を使おう](https://zenn.dev/kwaka1208/articles/bookmarklet-is-useful)

Manifest v3 に対応しており、プライバシーに配慮して「クリックした時だけ」タブの情報を取得する最小限の権限（`activeTab`）で設計されています。コピーした情報の収集や外部への送信も行なっていません。

日々の URL 共有作業が少しでも楽になれば幸いです。

準備が整ったら、ソースコードをGitHubで公開する予定です。
