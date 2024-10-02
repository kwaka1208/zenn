---
title: JSONデータから住所を取得しよう
---
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

まず、"data"の中にある情報を変数"json_data"に読み込みます。

![](/images/python/webapi/08.png)

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

各変数の内容をつないで表示します。

![](/images/python/webapi/10.png)

これれらの一連の処理をまとめると、以下のようになります。

![](/images/python/webapi/11.png)


### サンプルプログラム
ここで作成したプログラムは以下のリンクから開けます。
[郵便番号から住所を表示するプログラム](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/P5SsIXexlymfswn8zUCb)