---
title: Googleフォームの設問と選択肢をスプレッドシートに展開
emoji: "📋"
type: tech
topics: [Google スプレッドシート, Google フォーム]
published: true
---
## 概要
Googleフォームの設問と選択肢をスプレッドシートに展開するシートです。

## このツールでできること
以下の図のように、Googleフォームの設問と入力方法や選択肢をGoogleスプレッドシートに出力します。

例）展開元のGoogleフォームの内容
![](/images/google/export-form-to-spreadsheet/01.png =300x)

展開先のGoogleスプレッドシートの内容
![](/images/google/export-form-to-spreadsheet/02.png =300x)

## こんな時に使えます
- 作成済みのGoogleフォームの内容を元に資料を作りたい。
- Googleフォームの内容をレビューしたい

## 使い方
### 実行手順
1. シートのコピーを作成します。以下のリンク先をクリックするとシートのコピー画面が表示されます。コピーは最初の一回だけでOKですので、継続して利用する場合はコピーしたシートを使ってください。

[Export Google Form to Spreadsheet](https://docs.google.com/spreadsheets/d/1Q0YKNGBhEuMNGWB5gvBLQsvfACta36rxS1cGjFOkUNk/copy?usp=sharing)

コピーする時に以下のメッセージが表示されていることを確認してください。Apps Scriptの添付が必要です。

![](/images/google/export-form-to-spreadsheet/copy.png =300x)

2. コピーしたスプレッドシートを開き「パネル」シートのC2からC4に必要な情報を入力します。
    - C2：項目を抽出したいGoogleフォームのURL
    - C3：抽出した項目を書き出すスプレッドシートのURL。これを入力しなければ、コピーしたスプレッドシートの中に新たにシートを作ります。
    - C4：出力先のシートの名前
3. メニューの「フォームエクスポート」から「フォームからスプレッドシートへ出力」を選択すると処理を開始します。
4. 処理が終わると完了メッセージが表示されます。

#### 初回実行時のメッセージについて
最初の１回目だけ実行の許可を求める表示が出ます。
ざっくりいうと「ユーザーが作ったスクリプトなので、何が起こってもGoogleは責任を持ちませんよ、それでも使いますか？」という内容です。
仰っていることはもっともなのですが、許可がなければ動かせないので「信用するよ、使うよ」という方は以下の手順で、このシートに入ったスクリプトを実行する許可を与えてください。

最初に以下のメッセージがでますので、左下の「詳細」をクリックしてください。
![](/images/google/export-form-to-spreadsheet/c01.png =300x)

---

「（安全ではないページ）に移動」という失礼なメッセージがでてくるのでここをクリックしてください。正確には「安全性がGoogleによって確認されていない」だけであって「安全でない」と決めつけられるのは心外です。
![](/images/google/export-form-to-spreadsheet/c02.png =300x)

次の画面で「許可」を押すと、このシートに入ったスクリプトが実行可能となります。もう一度、上記3の操作を行なってください。
![](/images/google/export-form-to-spreadsheet/c03.png =300x)

### 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。