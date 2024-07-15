---
title: GoogleスプレッドシートのシートのデータをJSON形式で取得する
emoji: "📊"
type: tech
topics: [Google スプレッドシート, JSON]
published: false
---
## 概要
GoogleスプレッドシートのシートのデータをJSON形式で取得できるようにするシートです。このシートに表形式でデータを入力するとJSON形式で取得できるURLが取得できます。

## 使い方
1. シートのコピーを作成します。以下のリンク先をクリックするとシートのコピー画面が表示されます。コピーは最初の一回だけでOKですので、継続して利用する場合はコピーしたシートを使ってください。

[（コピーして使ってください）gs2json](https://docs.google.com/spreadsheets/d/1w5qHIz2qMAQlbS-FV3FTB_RGcEElKjCvGzJhJqyeDD8/copy?usp=sharing)

コピーする時に以下のメッセージが表示されていることを確認してください。Apps Scriptの添付が必要です。

![](/images/google/gs2json/copy.png)

2. "data"シートの内容を変更して取得したいデータを入力します。一行目はヘッダー行として扱われます。ヘッダー行の内容がJSONのキーとして出力されます。




### 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。