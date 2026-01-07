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

## 私が作ったブックマークレット
私が作ったブックマークレットを紹介します。

### 今見ているwebページをGoogle翻訳で日本語にする
英語など外国語のページを日本語に翻訳して読みたい時に使います。Google Chromeなどブラウザ標準で翻訳機能がついているものもありますが、このブックマークレットを使うと翻訳後のURLを取得できるので、他の方にシェアできます。

```javascript
javascript:location.href='https://translate.google.com/translate?sl=auto&tl=ja&u=%27+location.href
```

**使い方**
1. Google翻訳で日本語にしたいページを開く
2. ブックマークレットをクリックする
3. Google翻訳のページが表示される

### Internet Archive でウェブページの履歴を見る
Internet Archiveは、ウェブページの履歴を保存しているサービスです。このブックマークレットは、Internet Archiveでウェブページの履歴を見るためのURLを生成します。

```javascript
javascript:location.href='https://web.archive.org/web/20240000000000*/'+location.href
```
**使い方**
1. Internet Archiveで見たいページを開く
2. ブックマークレットをクリックする
3. Internet Archiveのページが表示される

### Googleドキュメント/スプレッドシート/スライドのURLを変換する

GoogleドキュメントやスプレッドシートのURLは最後が"/edit"で終わっていますが、ここを変えるとコピー専用やExcel形式、PDF形式でのダウンロード専用URLにできます。URLを手で編集するのは面倒なのでワンクリックで編集できるブックマークレットです。

以下の3つの形式のURLに変換できます（Excel形式でのダウンロードを選べるのはスプレッドシートのみです）。

- 指定したドキュメントなどのコピーを作る画面を開くURL
- 指定したスプレッドシートをExcel形式でダウンロードさせるURL
- 指定したドキュメントなどをPDF形式でダウンロードさせるURL

```javascript
javascript:(function(){ /* 編集画面とGoogleドメインをチェック */ var url = window.location.href; var hostname = window.location.hostname; /* Googleファイル判定: ホスト名がgoogle.comで終わること AND URLにファイルパスパターンが含まれること */ var isGoogleFile = hostname.endsWith('google.com') && url.includes('/d/'); var isSheet = url.includes('/spreadsheets/d/'); /* スプレッドシート判定をURLのパスで確認 */ var isSlides = url.includes('/presentation/d/'); /* スライド判定を追加 */ if (!isGoogleFile || url.indexOf('/edit') === -1) { alert('⚠️ Googleドキュメント、スプレッドシート、スライドなどの編集画面で実行してください。'); return; } /* 既存メニュー削除 */ var id = 'bm-url-converter-v2'; var old = document.getElementById(id); if (old) { old.remove(); return; } /* UI作成用関数（セキュリティ対策済み） */ function setStyle(el, css) { el.style.cssText = css; } /* コンテナ */ var div = document.createElement('div'); div.id = id; setStyle(div, 'position:fixed; top:20px; right:20px; z-index:999999; background:#222; color:#fff; padding:12px; border-radius:8px; box-shadow:0 4px 15px rgba(0,0,0,0.5); font-family:sans-serif; width:220px; text-align:left;'); /* ヘッダー */ var header = document.createElement('div'); setStyle(header, 'display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; border-bottom:1px solid #555; padding-bottom:5px; font-weight:bold;'); var title = document.createElement('span'); title.textContent = '共有URLをコピー'; var closeBtn = document.createElement('span'); closeBtn.textContent = '×'; setStyle(closeBtn, 'cursor:pointer; padding:0 5px; font-size:18px;'); closeBtn.onclick = function(){ div.remove(); }; header.appendChild(title); header.appendChild(closeBtn); div.appendChild(header); /* ボタン生成関数 */ function createBtn(label, suffix) { var btn = document.createElement('button'); btn.textContent = label; setStyle(btn, 'display:block; width:100%; padding:10px; margin:5px 0; background:#444; color:#fff; border:1px solid #666; border-radius:4px; cursor:pointer; text-align:left; font-size:13px;'); btn.onmouseover = function(){ this.style.background = '#666'; }; btn.onmouseout = function(){ this.style.background = '#444'; }; btn.onclick = function() { var newUrl = url.replace(/\/edit.*$/, suffix); navigator.clipboard.writeText(newUrl).then(function() { btn.textContent = '✅ コピー完了！'; btn.style.background = '#28a745'; setTimeout(function(){ div.remove(); }, 1200); }, function() { prompt('コピー失敗。手動コピー:', newUrl); }); }; div.appendChild(btn); } createBtn('1. 強制コピーモード', '/copy'); createBtn('2. PDFでダウンロード', '/export?format=pdf'); /* スプレッドシートのみExcelオプションを表示 */ if (isSheet) { createBtn('3. Excelでダウンロード', '/export?format=xlsx'); } document.body.appendChild(div); })();
```

**使い方**
1. Googleドキュメントやスプレッドシートを開く
2. ブックマークレットをクリックする
3. 変換後のURLがコピーされるのでメールなどに貼り付ける

### URLから余計なパラメータを取り除く

SNSでシェアされたリンクを開いてURLをコピーすると、`utm`や`fbclid`などのパラメータが付与されていることがあります。これらのパラメータはアクセス解析のために使われるもので、取り除きたい方も多いと思います（私もそのひとり）。

たとえば、FacebookでシェアされたYahoo! Japanのトップページを開くとアドレスバーの中のURLは以下のようになります。

![](/images/get-title-and-clean-url/01.png)

これをそのままコピーして共有すると、URLが長くなってしまい、見た目も良くありません。また、アクセス解析のためのパラメータが付与されていることで、プライバシーの観点からも気になる方もいるでしょう（上記URLのパラメータ部分は改変しています）。

ちなみに、本来はこちら

> https://www.yahoo.co.jp/

そこで、この余計なパラメータを取り除いてタイトルと一緒にクリップボードにコピーするブックマークレットを作りました。

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?')){const hq=u.hash.split('?');const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+'?'+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return document.title+'\n'+CLEAN(u)}catch(e){return document.title+'\n'+location.href}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData('text/plain',txt);ok=true};document.addEventListener('copy',onCopy,{once:true});ok=document.execCommand('copy');return ok}catch(e){}try{let ok=false;const ta=document.createElement('textarea');ta.value=txt;ta.setAttribute('readonly','');ta.style.position='fixed';ta.style.top='0';ta.style.left='0';ta.style.opacity='0';document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand('copy');ta.remove();if(ok)return true}catch(e){}prompt('Copy:\n',txt);return false};await copy(text)})();
```

**使い方**
1. URLを取得したいページを開きます。
2. ブックマークの「タイトルとクリーンURLをコピー」をクリックします。
3. クリップボードにタイトルとクリーンURLがコピーされます。
4. コピーに失敗した場合は、プロンプトが表示されるので、手動でコピーしてください。
5. 必要なところにペーストしてください。

- URLのパラメータのうち、`utm`や`fbclid`などのよく使われるものを取り除くようにしていますが、すべてのパラメータを取り除くわけではありません。必要に応じてコードを修正してください。
- ブックマークレットはブラウザのセキュリティ設定やブラウザの種類によっては動作しないことがあります。
- クリップボードへのコピーがブラウザのセキュリティ設定で制限されている場合、コピーに失敗することがあります。その場合は、プロンプトが表示されるので、手動でコピーしてください。

これらの派生バージョンも2つありますので、こちらも合わせて紹介します。使い方は同じです。

**Markdownのリンク形式でコピーする**

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?')){const hq=u.hash.split('?');const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+'?'+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return '[' +document.title+']('+CLEAN(u)+')'}catch(e){return '[' +document.title+']('+location.href+')'}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData('text/plain',txt);ok=true};document.addEventListener('copy',onCopy,{once:true});ok=document.execCommand('copy');return ok}catch(e){}try{let ok=false;const ta=document.createElement('textarea');ta.value=txt;ta.setAttribute('readonly','');ta.style.position='fixed';ta.style.top='0';ta.style.left='0';ta.style.opacity='0';document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand('copy');ta.remove();if(ok)return true}catch(e){}prompt('Copy:\n',txt);return false};await copy(text)})();
```

**スプレッドシートの並んだ二つ載せるに貼り付けられる形式でコピーする**

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?%27)){const hq=u.hash.split(%27?%27);const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+%27?%27+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return document.title+%27\t%27+CLEAN(u)}catch(e){return document.title+%27\t%27+location.href}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData(%27text/plain%27,txt);ok=true};document.addEventListener(%27copy%27,onCopy,{once:true});ok=document.execCommand(%27copy%27);return ok}catch(e){}try{let ok=false;const ta=document.createElement(%27textarea%27);ta.value=txt;ta.setAttribute(%27readonly%27,%27%27);ta.style.position=%27fixed%27;ta.style.top=%270%27;ta.style.left=%270%27;ta.style.opacity=%270%27;document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand(%27copy%27);ta.remove();if(ok)return true}catch(e){}prompt(%27Copy:\n%27,txt);return false};await copy(text)})();
```

### 今見ているwebページのOGP画像を別タブで開く

上に書いた通りです。OGP画像の設定を確認したい場合などに使えます。

```javascript
javascript:(function(){const e=document.querySelector('meta[property="og:image"]');if(e){window.open(e.content,'_blank')}else{alert("このページにはOGP画像が設定されていません。")}})();
```

**使い方**
1. OGP画像を確認したいページを開く
2. ブックマークレットをクリックする
3. OGP画像が別タブで表示される。OGP画像が設定されていない、取得できない場合は「このページにはOGP画像が設定されていません。」というメッセージが表示されます。

## 誰かが作ったブックマークレット
以下は、自作ではなく他のページで見つけたブックマークレットです。どこで見つけたのかを忘れてしまったので、出展を思い出したら追記します。

### Amazonの商品ページのシンプルなURLを取得する
Amazonの商品ページのURLは、商品の名前が入るととても長くなります。このブックマークレットは不要な情報を削除して商品コードだけのシンプルな（短い）URLを作成します。

```javascript
javascript:(function()%7Bs=location.href;s='https://amazon.jp/dp/'+s.substr(s.search(/(%5C/product%5C/%7C%5C/dp%5C/)/)).split('/')%5B2%5D.substr(0,10);prompt(unescape('%25u77ED%25u3044URL%25u306F%25u4E0B%25u8A18%25u306E%25u901A%25u308A%25u3067%25u3059%25u3002'),s);%7D)();
```

**使い方**
1. Amazonの商品ページを開く
2. ブックマークレットをクリックする
3. ダイアログでにURLが表示されるので、コピーする

### Amazonのページからカーリルで検索する
```javascript
javascript:if(location.href.search(/%5B%5E0-9A-Z%5D(%5BB0-9%5D%5B0-9A-Z%5D%7B9%7D)(%5B%5E0-9A-Z%5D%7C$)/)!=-1)%7Bvoid(location.href='http://calil.jp/book/'+RegExp.$1);%7D
```
**使い方**
1. Amazonの商品ページを開く
2. ブックマークレットをクリックする
3. カーリルの検索結果が表示される
