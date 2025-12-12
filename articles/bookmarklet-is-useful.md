---
title: Bookmarklet（ブックマークレット）を使おう
emoji: "🔖"
type: idea
topics: [ブックマークレット,bokkmarklet, ブラウザ]
published: true
---
## 概要
ブックマークレット（Bookmarklet）は、ブラウザのブックマーク機能を使って、JavaScriptを実行するための方法です。JavaScriptをブラウザのアドレスバーに登録しておくことで、そのページでJavaScriptを実行することができます。

ブックマークからJavaScriptが実行できると何がいいかというと、現在見ているページと関連する処理を実行したり、ページの情報を取得したりすることができるようになります。例えば、Amazonの商品ページのURLを短くするブックマークレットや、Google翻訳でページを日本語にするブックマークレットなどがあります。

この記事では、ブックマークレットの登録手順と私がよく使っているブックマークレットを紹介します。

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

名前のところは自分でわかりやすい名前を、URLの欄にブックマークレットとして使うJavaScriptを入力します。この記事にもいくつかJavaScriptを掲載していますので、コピーしてURL欄に貼り付けてください。

![](/images/bookmarklet-is-useful/03.png)

4. ブックマークレットを実行する
ブックマークレットを実行するには、ブックマークをクリックするだけです。ブックマークレットが実行されると、そのページでJavaScriptが実行されます。

## 私がよく使うブックマークレット
以下に私がよく使うブックマークレットを紹介します。

### 私が作ったブックマークレット
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

#### Googleドキュメント/スプレッドシート/スライドのURLを変換する

GoogleドキュメントやスプレッドシートのURLは最後が"/edit"で終わっていますが、ここを変えるとコピー専用やExcel形式、PDF形式でのダウンロード専用URLにできます。URLを手で編集するのは面倒なのでワンクリックで編集できるブックマークレットです。

以下の3つの形式のURLに変換できます（Excel形式でのダウンロードを選べるのはスプレッドシートのみです）。

- 指定したドキュメントなどのコピーを作る画面を開くURL
- 指定したスプレッドシートをExcel形式でダウンロードさせるURL
- 指定したドキュメントなどをPDF形式でダウンロードさせるURL


**使い方**
1. Googleドキュメントやスプレッドシートを開く
2. ブックマークレットをクリックする
3. 変換後のURLがコピーされるのでメールなどに貼り付ける

```javascript
javascript(function(){ /* 編集画面とGoogleドメインをチェック */ var url = window.location.href; var hostname = window.location.hostname; /* Googleファイル判定: ホスト名がgoogle.comで終わること AND URLにファイルパスパターンが含まれること */ var isGoogleFile = hostname.endsWith('google.com') && url.includes('/d/'); var isSheet = url.includes('/spreadsheets/d/'); /* スプレッドシート判定をURLのパスで確認 */ var isSlides = url.includes('/presentation/d/'); /* スライド判定を追加 */ if (!isGoogleFile || url.indexOf('/edit') === -1) { alert('⚠️ Googleドキュメント、スプレッドシート、スライドなどの編集画面で実行してください。'); return; } /* 既存メニュー削除 */ var id = 'bm-url-converter-v2'; var old = document.getElementById(id); if (old) { old.remove(); return; } /* UI作成用関数（セキュリティ対策済み） */ function setStyle(el, css) { el.style.cssText = css; } /* コンテナ */ var div = document.createElement('div'); div.id = id; setStyle(div, 'position:fixed; top:20px; right:20px; z-index:999999; background:#222; color:#fff; padding:12px; border-radius:8px; box-shadow:0 4px 15px rgba(0,0,0,0.5); font-family:sans-serif; width:220px; text-align:left;'); /* ヘッダー */ var header = document.createElement('div'); setStyle(header, 'display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; border-bottom:1px solid #555; padding-bottom:5px; font-weight:bold;'); var title = document.createElement('span'); title.textContent = '共有URLをコピー'; var closeBtn = document.createElement('span'); closeBtn.textContent = '×'; setStyle(closeBtn, 'cursor:pointer; padding:0 5px; font-size:18px;'); closeBtn.onclick = function(){ div.remove(); }; header.appendChild(title); header.appendChild(closeBtn); div.appendChild(header); /* ボタン生成関数 */ function createBtn(label, suffix) { var btn = document.createElement('button'); btn.textContent = label; setStyle(btn, 'display:block; width:100%; padding:10px; margin:5px 0; background:#444; color:#fff; border:1px solid #666; border-radius:4px; cursor:pointer; text-align:left; font-size:13px;'); btn.onmouseover = function(){ this.style.background = '#666'; }; btn.onmouseout = function(){ this.style.background = '#444'; }; btn.onclick = function() { var newUrl = url.replace(/\/edit.*$/, suffix); navigator.clipboard.writeText(newUrl).then(function() { btn.textContent = '✅ コピー完了！'; btn.style.background = '#28a745'; setTimeout(function(){ div.remove(); }, 1200); }, function() { prompt('コピー失敗。手動コピー:', newUrl); }); }; div.appendChild(btn); } createBtn('1. 強制コピーモード', '/copy'); createBtn('2. PDFでダウンロード', '/export?format=pdf'); /* スプレッドシートのみExcelオプションを表示 */ if (isSheet) { createBtn('3. Excelでダウンロード', '/export?format=xlsx'); } document.body.appendChild(div); })();
```

### 誰かが作ったブックマークレット
以下は、自作ではなく他のページで見つけたブックマークレットです。どこで見つけたのかを忘れてしまったので、出展を思い出したら追記します。

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
