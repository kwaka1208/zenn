---
title: Googleスプレッドシートでらくらく日程調整「日程さん」
emoji: "📅"
type: idea
topics: [Googleスプレッドシート, 日程調整]
published: false
---
## 概要

会議や飲み会の日程調整をする時、調整さんなどのクラウドツールを使ったことがある方は多いかと思います。

https://chouseisan.com/

「日程さん」はこういった日程調整機能をスプレッドシートで実現したものです。一般的な日程調整サービスと違い、あらかじめ記入予定者の名前をいれておけるので、誰が未記入かを把握しやすいのが特徴です。

## 画面例

![](/images/find-a-date-time/sample.png)

## 使い方
1. 設定シートのコピーを作成します。以下のリンク先をクリックするとシートのコピー画面が表示されます。コピーは最初の一回だけでOKですので、継続して利用する場合はコピーしたシートを使ってください。

https://docs.google.com/spreadsheets/d/1hRIQ9YZFV9aVpIj1ZTy3BFYeGU3lL5EaWS4dmDzI5b0/copy?gid=377660851

コピーする時に以下のメッセージが表示されていることを確認してください。Apps Scriptの添付が必要です。

![](/images/find-a-date-time/copy.png =500x)

1. A列に入力を依頼する方の名前を入力します。
2. 入力を依頼する方を編集者として共有し、URLを共有します。
3. 入力されると一番下の列に集計結果が表示されます。

### 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。