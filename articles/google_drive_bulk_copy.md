---
title: Google Driveでフォルダ階層をまるごとコピーする
emoji: 📁
type: tech
topics: [Google Drive,Google Workspace]
published: true
---
:::message
v2にアップデートしました。以前は、対象のフォルダ数が多い場合の処理タイムアウトエラーに対応していませんでしたが、今回のバージョンで対象となるフォルダ数が多い場合でも続行ができるようになりました。また、操作性も改善しました。
:::

## 概要
Google Driveでは、フォルダの内容（ファイル、サブフォルダ）をまるごと移動はできますが、コピーはできません。

このツールは、Google Driveの指定したフォルダを別のフォルダにコピーするためのツールです。フォルダ階層のみのコピー、フォルダとファイルすべてのコピーの両方に対応しています。

Googleスプレッドシートに情報を入力して使うようになっていますので、どなたでも使えます。

## このツールでできること
以下の図のように、あるGoogleアカウントで作成されたGoogle Driveのフォルダを、別のGoogleアカウントのGoogle Driveにコピーします。

![](/images/google/google_drive_bulk_copy/01.png)

コピー先は、コピー元と同じフォルダ構造で作成されます。また、コピー先は同一Googleアカウントでも構いません。

## こんな時に使えます
- あるユーザーがオーナーのフォルダをまとめて別のユーザーに移行したい場合。（異なるGoogleアカウント間でのコピー）
- 既存のフォルダと同じフォルダ構造をもうひとつ作りたい（年度単位で同じフォルダ構成を作りたいなど）場合。

## 使い方
### 前準備
- コピー先のフォルダを作成してください。コピー先のフォルダを作成する。
- コピー元のフォルダをコピー先フォルダのGoogleアカウントに対して共有します（編集権限があればOKです）。

### 実行手順
1. 設定シートのコピーを作成します。以下のリンク先をクリックするとシートのコピー画面が表示されます。コピーは最初の一回だけでOKですので、継続して利用する場合はコピーしたシートを使ってください。

[フォルダまるごとコピーv2](https://docs.google.com/spreadsheets/d/1gGr3XXWkEU1gOztkUnfrvDNhhXqBglOd_ADHEMc2vOM/copy?usp=sharing)

コピーする時に以下のメッセージが表示されていることを確認してください。Apps Scriptの添付が必要です。

![](/images/common/copy.png =500x)

2. コピー元フォルダURLの欄（青色背景）にコピー元のGoogle DriveのフォルダURLを入力してください。
3. コピー先フォルダURLの欄（赤色背景）にコピー先のGoogle DriveのフォルダURLを入力してください。

:::message
Google DriveのフォルダURLは、フォルダを開いた状態でアドレスバーに表示されたURLをコピーして貼り付けてください。
:::

![](/images/google/google_drive_bulk_copy/02.png)


3 .メニューの「カスタムメニュー」から以下の順で項目を選択します。
最初の１回目だけ実行の許可を求める表示が出ます。実行の許可を与えた後、もう一度「フォルダリスト作成（新規）」を押してください。
いずれも最後に「〜が完了しました」というメッセージが出ますので、それまではタブを閉じないでください。

:::message
GAS（Google Apps Script）の仕様で一回あたりの実行時間に上限があるため、操作を複数に分けています。「〜が完了しました」のメッセージが出る前に処理が終わってしまう場合もありますが、その場合も継続できるようになっています。
:::

|メニュー項目|説明|
|:--:|:--|
|フォルダリスト作成（新規）|コピー元のフォルダのリストを作成します。最初は必ずここから実行してください。|
|フォルダリスト作成（継続）|上記フォルダリストの作成が途中で終わった場合は、「〜が完了しました」のメッセージがでるまで、こちらを実行してください。|
|コピー先フォルダ作成|コピー元のフォルダのリストができたら、コピー先のフォルダを作成します。このメニューの実行が途中で終わった場合は、「〜が完了しました」のメッセージがでるまで、繰り返し実行してください。こちらは「新規」と「継続」の区別はありません。|
|ファイルコピー|コピー先のフォルダができたら、ファイルのコピーを実行します。このメニューの実行が途中で終わった場合は、「〜が完了しました」のメッセージがでるまで、繰り返し実行してください。こちらは「新規」と「継続」の区別はありません。|

4. いずれも「〜が完了しました」のメッセージが表示されたら終了です。	

::::message
初回実行時のみ認証を求められます。認証を求められた時の対応については以下をご覧ください。
:::details ここをクリックすると手順が表示されます
最初の１回目だけ実行の許可を求める表示が出ます。
ざっくりいうと「ユーザーが作ったスクリプトなので、何が起こってもGoogleは責任を持ちませんよ、それでも使いますか？」という内容です。
仰っていることはもっともなのですが、許可がなければ動かせないので「信用するよ、使うよ」という方は以下の手順で、このシートに入ったスクリプトを実行する許可を与えてください。

1. 最初に以下のメッセージがでますので、「OK」を押してください。
![](/images/common/auth01.png =500x)
2. ご自身のGoogleアカウントを選択してください。
![](/images/common/auth02.png =500x)
3. アプリ（スクリプト）がGoogleの確認を受けていないものですよ、ということを示す警告がでますので、左下の「詳細」押してください。
![](/images/common/auth03.png =500x)
4. 下の方に「（安全ではないページ）に移動」という失礼なメッセージがでてくるのでここをクリックしてください。正確には「安全性がGoogleによって確認されていない」だけであって「安全でない」と決めつけられるのは心外です。
![](/images/common/auth04.png =500x)
5. さらに確認画面が出てきますので「次へ」を押します。
![](/images/common/auth05.png =500x)
6. どのような情報へのアクセスに対して許可を求められているかが表示されます。内容を確認の上「許可」を押してください。
![](/images/common/auth06.png =500x)
![](/images/common/auth07.png =500x)
7. 以上でスクリプトが使えるようになります。今後はこの操作は不要ですが、もう一度スクリプトの実行操作を行ってください。
:::
::::

## お読みください
- コピー後のファイルは、処理を実行した人がオーナーになります。元のオーナーは引きがれませんのでご注意ください。

## ソースコードについて
このツールのソースコードは、MITライセンスで公開しています。

https://github.com/kwaka1208/gas_bulk_copy

## 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。

