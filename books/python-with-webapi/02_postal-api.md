---
title: 郵便番号から住所を調べよう
---
## はじめに
郵便番号から住所の情報を取得できるAPI[Postal Code API（以下、郵便番号APIと呼びます）](https://madefor.github.io/postal-code-api/)を使って、入力された郵便番号から住所を表示するプログラムを作ってみましょう。

## やってみよう
### 郵便番号APIを使ってみよう
[郵便番号APIのページ](https://madefor.github.io/postal-code-api/)にアクセスして、色々な郵便番号を入力してみましょう。

たとえば、これらはどこの郵便番号でしょう？
```
554-0031
279-0031
100-0001
```

### プログラムからの使い方
郵便番号APIは、GitHubと呼ばれるサービスを使って提供されています。詳しい使い方は、[GitHubリポジトリ](https://github.com/madefor/postal-code-api)に書かれていますが、ここでは簡単に説明します。

以下のURLの'123'の部分を郵便番号の最初の3桁、'4567'の部分を郵便番号の後の3桁に置き換えると、その郵便番号の住所の情報が取得できます。

```
https://madefor.github.io/postal-code-api/api/v1/123/4567.json
```

たとえば、554-0031の住所を取得したい場合は、以下のURLにアクセスします。

[https://madefor.github.io/postal-code-api/api/v1/554/0031.json](https://madefor.github.io/postal-code-api/api/v1/554/0031.json)

このURLにアクセスすると、[郵便番号APIのページ](https://madefor.github.io/postal-code-api/)で試したものと同じデータが表示されます（こちらは1行になります）。

### インターネットからデータを取得する
ここまでの操作をプログラムで実行してみましょう。

#### ブロック版
![](/images/python/webapi/01.png)

#### テキスト版
```python!
#Start code here
import requests
api = "https://madefor.github.io/postal-code-api/api/v1/100/0001.json"
data = requests.get(api)
print(data.text)
```
#### 色々な郵便番号で試してみましょう
1. プログラムを入力したら、変数apiの中の郵便番号を書き換えて、実行してみましょう。

### サンプルプログラム
ここで作成したプログラムは以下のリンクから開けます。
[プログラムデータはこちら](https://app.edublocks.org/project/C07T9nfaVWeZkZj3D6DF7vZPGlM2/I1o7HSHZyY22T7gHuXkD
)
