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
- Markdown 形式でリンクを作りたいが、タイトルと URL を行ったり来たりするのが手間
- Google ドキュメントを PDF で共有したいが、変換メニューを探すのが煩わしい

これらをまとめて解決するために開発したのが、Chrome 拡張機能 **「PagePick」** です。

[PagePick - Chrome ウェブストア](https://chromewebstore.google.com/detail/pagepick/ffomibplfijjbilnblogaankmhnebbmp)

## できること

### 1. トラッキングパラメータの自動削除 & URL コピー
コピー時に、不要なパラメータ（`utm_*`, `fbclid`, `gclid` など）を自動で取り除きます。
以下の3つの形式をサポートしています：

- **TSV 形式**: `タイトル [TAB] URL`（スプレッドシートへの貼り付けに最適）
- **改行区切り 形式**: `タイトル [改行] URL`（チャット等での共有に便利）
- **Markdown 形式**: `[タイトル](URL)`（ドキュメント作成に）

### 2. Google Docs / Sheets / Slides 変換
Google のドキュメント系アプリの編集画面で実行すると、特殊な変換メニューがページ上に表示されます。

- **強制コピーモード**: `/copy` 形式の URL をコピー
- **PDF でダウンロード**: `/export?format=pdf` 形式の URL をコピー
- **Excel でダウンロード**: スプレッドシートの場合、`.xlsx` 形式の URL をコピー

共有相手に「コピーして使ってね」と伝えたいときや、直接 PDF を送りたいときに非常に便利です。

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
