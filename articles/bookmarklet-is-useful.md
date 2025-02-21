---
title: Bookmaklet（ブックマークレット）を使おう
emoji: "🔖"
type: idea
topics: [ブックマークレット,bokkmarklet, ブラウザ]
published: false
---
## 概要
ブックマークレット（Bookmarklet）は、ブラウザのブックマーク機能を使って、JavaScriptを実行するための方法です。JavaScriptをブラウザのアドレスバーに登録しておくことで、そのページでJavaScriptを実行することができます。

ブックマークからJavaScriptが実行できると何がいいかというと、現在見ているページと関連する処理を実行したり、ページの情報を取得したりすることができるようになります。例えば、Amazonの商品ページのURLを短くするブックマークレットや、Google翻訳でページを日本語にするブックマークレットなどがあります。

この記事では、私がよく使っているブックマークレットとその登録方法を案内します。

## ブックマークレットの登録方法
ブックマークレットを登録する方法は、以下の手順で行います。

1. 新しいブックマークを追加する  
あとで書き換えますので、どのページでも結構です。とにかく、ひとつブックマークを登録してください。

2. ブックマークの編集画面を開く
ブラウザによって操作方法が異なりますので、お使いのブラウザの操作方法を調べてください。ここではChromeの場合を例に説明します。Chromeの場合、ブックマークバーに登録したブックマークを右クリックして「編集」を選択します。

![](/images/bookmarklet-is-useful/01.png)

3. ブックマークの名前とURLを編集する
Yahoo! JAPANを登録した場合、ブックマークの内容は以下の通りとなります。
![](/images/bookmarklet-is-useful/02.png)

名前のところは自分でわかりやすい名前を、URLの欄にブックマークレットとして使うJavaScriptを入力します。
![](/images/bookmarklet-is-useful/03.png)

4. ブックマークレットを実行する
ブックマークレットを実行するには、ブックマークをクリックするだけです。ブックマークレットが実行されると、そのページでJavaScriptが実行されます。

## わたしがよく使うブックマークレット
以下に私がよく使うブックマークレットを紹介します。


### 自作ブックマークレット
#### 今見ているwebページをGoogle翻訳で日本語にする
英語など外国語のページを日本語に翻訳して読みたい時に使います。Google Chromeなどブラウザ標準で翻訳機能がついているものもありますが、このブックマークレットを使うと翻訳後のURLを取得できるので、他の方にシェアできます。

```javascript
javascript:location.href='https://translate.google.com/translate?sl=auto&tl=ja&u=%27+location.href
```

**使い方**
1. Google翻訳で日本語にしたいページを開く
2. ブックマークレットをクリックする
3. Google翻訳のページが表示される

#### Internet Archive でウェブページの履歴を見る
Internet Archiveは、ウェブページの履歴を保存しているサービスです。このブックマークレットは、Internet Archiveでウェブページの履歴を見るためのURLを生成します。

```javascript
javascript:location.href='https://web.archive.org/web/20240000000000*/'+location.href
```
**使い方**
1. Internet Archiveで見たいページを開く
2. ブックマークレットをクリックする
3. Internet Archiveのページが表示される

#### Amazonの商品ページのシンプルなURLを取得する
Amazonの商品ページのURLは、商品の名前が入るととても長くなります。このブックマークレットは不要な情報を削除して商品コードだけのシンプルな（短い）URLを作成します。

```javascript
javascript:(function()%7Bs=location.href;s='https://amazon.jp/dp/'+s.substr(s.search(/(%5C/product%5C/%7C%5C/dp%5C/)/)).split('/')%5B2%5D.substr(0,10);prompt(unescape('%25u77ED%25u3044URL%25u306F%25u4E0B%25u8A18%25u306E%25u901A%25u308A%25u3067%25u3059%25u3002'),s);%7D)();
```

**使い方**
1. Amazonの商品ページを開く
2. ブックマークレットをクリックする
3. ダイアログでにURLが表示されるので、コピーする

#### Amazonのページからカーリルで検索する
```javascript
javascript:if(location.href.search(/%5B%5E0-9A-Z%5D(%5BB0-9%5D%5B0-9A-Z%5D%7B9%7D)(%5B%5E0-9A-Z%5D%7C$)/)!=-1)%7Bvoid(location.href='http://calil.jp/book/'+RegExp.$1);%7D
```
**使い方**
1. Amazonの商品ページを開く
2. ブックマークレットをクリックする
3. カーリルの検索結果が表示される
