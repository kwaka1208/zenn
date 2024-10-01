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

このデータにアクセスするプログラムは以下のリンクから開けます。

[フルーツのデータにアクセスするプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/nvsq5pUUDAN27r2AOklT)

![Screenshot 2024-09-25 at 20.09.12](https://hackmd.io/_uploads/S1GFyO-RA.png)

フルーツのJSONデータは変数"data"の中に入っているので、次のように読むことができます。

![Screenshot 2024-09-25 at 19.51.36](https://hackmd.io/_uploads/HyAehP-AR.png)

