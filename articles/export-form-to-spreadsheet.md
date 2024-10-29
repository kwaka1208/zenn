---
title: Googleフォームの設問と選択肢をスプレッドシートに展開
emoji: "📋"
type: tech
topics: [Google スプレッドシート, Google フォーム]
published: false
---
## 概要
Googleフォームの設問と選択肢をスプレッドシートに展開するシートです。

## このツールでできること
以下の図のように、Googleフォームの設問と入力方法や選択肢をGoogleスプレッドシートに出力します。

例）展開元のGoogleフォームの内容
![](/images/google/export-form-to-spreadsheet/01.png)

展開先のGoogleスプレッドシートの内容
![](/images/google/export-form-to-spreadsheet/02.png)

## こんな時に使えます
- 作成済みのGoogleフォームの内容を元に資料を作りたい。
- Googleフォームの内容をレビューしたい

## 使い方
## 実行手順
1. シートのコピーを作成します。以下のリンク先をクリックするとシートのコピー画面が表示されます。コピーは最初の一回だけでOKですので、継続して利用する場合はコピーしたシートを使ってください。

[Export Google Form to Spreadsheet](https://docs.google.com/spreadsheets/d/1Q0YKNGBhEuMNGWB5gvBLQsvfACta36rxS1cGjFOkUNk/copy?usp=sharing)

コピーする時に以下のメッセージが表示されていることを確認してください。Apps Scriptの添付が必要です。

![](/images/google/export-form-to-spreadsheet/copy.png)

2. コピーしたスプレッドシートを開き「パネル」シートのC2からC4に必要な情報を入力します。
    - C2：項目を抽出したいGoogleフォームのURL
    - C3：抽出した項目を書き出すスプレッドシートのURL。これを入力しなければ、コピーしたスプレッドシートの中に新たにシートを作ります。
    - C4：出力先のシートの名前
3. メニューの「フォームエクスポート」から「フォームからスプレッドシートへ出力」を選択すると処理を開始します。

:::message alert
最初の１回目だけ実行の許可を求める表示が出ます。実行の許可を与えた後、もう一度「フォームからスプレッドシートへ出力」を実行してください。
:::

4. 処理が終わると完了メッセージが表示されます。

### 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。