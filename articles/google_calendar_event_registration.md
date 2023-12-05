---
title: Googleカレンダー一括イベント登録
emoji: "📅"
type: tech
topics: [Google Calendar,Google Workspace]
published: true
---
## 概要
Googleカレンダーに複数のイベントを一括登録するツールです。繰り返しイベントだとGoogleカレンダーの機能で登録できますが、こちらは不定期開催のイベントの登録やイベントタイトルに一連番号をつけられます。

## 使い方
下記リンク先のスプレッドシートをコピーし、各列に必要事項を記入して「カレンダーに登録」ボタンを押してください。

[Googleカレンダー一括イベント登録（Googleスプレッドシート）](https://bit.ly/3UXGHZ1)

「カレンダーに登録」ボタンを押した時、最初の1回だけ承認依頼画面がでますので、承認後にもう一度「カレンダーに登録」ボタンを押してください。2回目以降承認は不要です。

## スプレッドシートの各列の意味

|項目名|意味|値の範囲|
|:--:|:--|:--|
|カレンダーID|登録するカレンダーのIDです|欄外の「カレンダーIDの取得方法」をご覧ください|
|タイトル|イベントのタイトル|**必須**|
|開始時間|イベントの開始時刻|"9:00"のように"時:分"の形式で入力してください。空欄の場合は終日イベントとして登録されます。|
|終了時間|イベントの終了時刻|（任意）|
|說明|イベントの説明|（任意）|
|場所|イベントの開催場所|（任意）|
|招待先|招待を送る相手|Googleアカウントをカンマ区切りで入力（任意）|
|招待メール|招待相手にメールでの通知を送る設定|0:送らない, 1:送る|
|連番桁数|イベントタイトルの前につける連番の桁数。|0:連番は付与しない。1以上:連番付与する（例：2の場合、"01"のようにゼロ埋めの番号がつきます|
|Day 1〜20|イベントを設定したい日付を入れます|20で足りない場合は適宜列を増やしてください|

### カレンダーIDの取得方法
カレンダーIDは、Googleカレンダーの各カレンダーの設定画面に記載されているものをコピーします。

- Googleカレンダーの「マイカレンダー」から設定したいカレンダーの上にマウスを移動させ表示される点3つのボタンから「設定と共有」を選びます。
- 「カレンダーの設定」画面が表示されますので、画面の中ほどにある「カレンダーの統合」の下にある「カレンダーID」からカレンダーIDをコピーします。カレンダーIDはアルファベットと数字が組み合わさった長いメールアドレスのような形式になっていますので、すべてをコピーしてください。

![カレンダーIDの記載箇所](/images/google/calendar-id.png)

### 不具合の報告などはこちらへ
こちらのシートに不具合がございましたら、[こちら](https://github.com/kwaka1208/issues/issues)から報告いただけると助かります。