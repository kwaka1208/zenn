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

このプログラムでは、変数"data"の中の"fruit"の中身を取り出し、変数"json_data"に辞書型と呼ばれる形式で保存しています。辞書型にすると、データの場所を指定して取り出せるようになります。

![](/images/python/webapi/05.png)

上記の情報はプログラムで次のようにアクセスできます。

```text
りんごの情報：json_data[0]
りんごの名前の情報：json_data[0]["name"]
りんごの在庫の情報：json_data[0]["stock"]
りんごの価格の情報：json_data[0]["price"]
```
これを使って、りんごの情報を表示するプログラムを作成してみましょう。

![](/images/python/webapi/05.png)

みかんとバナナについてもどうように表示するプログラムを作成してみましょう（全ての情報を表示するプログラムはサンプルプログラムからリンクしています）。

### サンプルプログラム
ここで作成したプログラムは以下のリンクから開けます。
1. [フルーツのデータにアクセスするプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/nvsq5pUUDAN27r2AOklT)
1. [フルーツのデータを表示するプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/Tl5WUoSbXivIY06N9I76)
