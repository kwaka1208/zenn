---
title: JSONデータから住所を取得しよう
---
では、実際に住所のデータを取得してみましょう、ここでは"100-0001"という郵便番号を指定して、その住所を取得します。

[https://madefor.github.io/postal-code-api/api/v1/100/0001.json](https://madefor.github.io/postal-code-api/api/v1/100/0001.json)

## データの中身を見てみよう
このURLにアクセスすると、以下のようなデータが取得できます。

```json
{
    "code": "1000001",
    "data": [
        {
            "prefcode": "13",
            "ja": {
                "prefecture": "東京都",
                "address1": "千代田区",
                "address2": "千代田",
                "address3": "",
                "address4": ""
            },
            "en": {
                "prefecture": "Tokyo",
                "address1": "Chiyoda-ku",
                "address2": "Chiyoda",
                "address3": "",
                "address4": ""
            }
        }
    ]
}
```
このデータを見ていくと、"data"の中に日本語の住所情報"ja"が含まれていることがわかります。この部分を指定して取り出します。

![](/images/python/webapi/07.png)

## JSONデータを変数に読み込む
まず、"data"の中にある情報を変数"json_data"に読み込みます。

![](/images/python/webapi/08.png)

## 住所情報の場所を確認する
次に、"json_data"の中にある"ja"の中にある住所情報を取り出します。

```
住所の情報：json_data[0]
日本語の住所の情報：json_data[0]["ja"]
日本語の都道府県の情報：json_data[0]["ja"]["prefecture"]
日本語の住所1の情報：json_data[0]["ja"]["address1"]
日本語の住所2の情報：json_data[0]["ja"]["address2"]
日本語の住所3の情報：json_data[0]["ja"]["address3"]
```
![](/images/python/webapi/09.png)

## 住所情報をひとつにまとめる
各変数の内容をつないで表示します。

![](/images/python/webapi/10.png)


## ここまでの完成版
これらの一連の処理をまとめると、以下のようになります。

![](/images/python/webapi/11.png)


### サンプルプログラム
ここで作成したプログラムは以下のリンクから開けます。
[郵便番号から住所を表示するプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/P5SsIXexlymfswn8zUCb)