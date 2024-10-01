---
title: JSONデータから欲しい情報を取り出そう
---
## フルーツの情報を取り出そう
前回使ったフルーツのデータを用意しました。ここから名前や金額などを表示してみましょう。

[JSON形式のフルーツのデータ](https://crssrds.jp/assets/resources/json/fruits.json)

```jsonld
{
  "fruit":  [
      {"name": "りんご", "stock": 50, "price": 100},
      {"name": "みかん", "stock": 75, "price": 200},
      {"name": "バナナ", "stock": 90, "price": 150}
  ]
}
```
### JSONデータにアクセスする
まず、JSONデータを変数に取り込みます。

![](/images/python/webapi/03.png)

この時点では、変数"data"の中は文字列の情報なので、json関数を使ってプログラムで使いやすい形（辞書型）に変換します。

![](/images/python/webapi/04.png)

変数"json_data"には、変数"data"の中の"fruit"の中身が入っています。

![](/images/python/webapi/05.png)


### サンプルプログラム
ここで作成したプログラムは以下のリンクから開けます。
[フルーツのデータにアクセスするプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/nvsq5pUUDAN27r2AOklT)


