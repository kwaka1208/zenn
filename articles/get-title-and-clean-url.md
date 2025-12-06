---
title: URLを綺麗にして取得するブックマークレット
emoji: 🧹
type: tech
topics: [JavaScript, ブックマークレット, URL, コピー]
published: true
---
SNSでシェアされたリンクを開いてURLをコピーすると、`utm`や`fbclid`などのパラメータが付与されていることがあります。これらのパラメータはアクセス解析のために使われるもので、取り除きたい方も多いと思います（私もそのひとり）。

たとえば、FacebookでシェアされたYahoo! Japanのトップページを開くとアドレスバーの中のURLは以下のようになります。

![](/images/get-title-and-clean-url/01.png)

これをそのままコピーして共有すると、URLが長くなってしまい、見た目も良くありません。また、アクセス解析のためのパラメータが付与されていることで、プライバシーの観点からも気になる方もいるでしょう（上記URLのパラメータ部分は改変しています）。

ちなみに、本来はこちら

> https://www.yahoo.co.jp/

そこで、この余計なパラメータを取り除いてタイトルと一緒にクリップボードにコピーするブックマークレットを紹介します。

## ブックマークレットとは
ブックマークレットとは、ブラウザのブックマークに登録しておくことで、クリックするだけでJavaScriptのコードを実行できる仕組みで、ブラウザの拡張機能のようなことが実現できる仕組みです。

ブラウザの拡張機能と違うのは、JavaScriptが実行できるブラウザであれば、

- ブウラザを問わず使える
- スマートフォンでも動作する

という点にあります。

## ブックマークレットの登録の仕方

ブックマークレットの登録手順については、以下の記事に画像入りでまとめています。こちらをご覧ください。

https://zenn.dev/kwaka1208/articles/bookmarklet-is-useful

## ブックマークレットのコード
ブックマークのURL欄に以下のコードをコピー＆ペーストしてください。

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?')){const hq=u.hash.split('?');const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+'?'+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return document.title+'\n'+CLEAN(u)}catch(e){return document.title+'\n'+location.href}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData('text/plain',txt);ok=true};document.addEventListener('copy',onCopy,{once:true});ok=document.execCommand('copy');return ok}catch(e){}try{let ok=false;const ta=document.createElement('textarea');ta.value=txt;ta.setAttribute('readonly','');ta.style.position='fixed';ta.style.top='0';ta.style.left='0';ta.style.opacity='0';document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand('copy');ta.remove();if(ok)return true}catch(e){}prompt('Copy:\n',txt);return false};await copy(text)})();
```

## 使い方
1. URLを取得したいページを開きます。
2. ブックマークの「タイトルとクリーンURLをコピー」をクリックします。
3. クリップボードにタイトルとクリーンURLがコピーされます。
4. コピーに失敗した場合は、プロンプトが表示されるので、手動でコピーしてください。
5. 必要なところにペーストしてください。

## 注意点
- URLのパラメータのうち、`utm`や`fbclid`などのよく使われるものを取り除くようにしていますが、すべてのパラメータを取り除くわけではありません。必要に応じてコードを修正してください。
- ブックマークレットはブラウザのセキュリティ設定やブラウザの種類によっては動作しないことがあります。
- クリップボードへのコピーがブラウザのセキュリティ設定で制限されている場合、コピーに失敗することがあります。その場合は、プロンプトが表示されるので、手動でコピーしてください。
- ブックマークレットのコードは長いので、コピー＆ペーストの際に途中で切れてしまうことがあります。コードがすべてコピーされていることを確認してください。
- ブックマークレットのコードは、`javascript:`で始まる必要があります。コピー＆ペーストの際に`javascript:`が抜けてしまうことがあるので注意してください。
- ブックマークレットのコードは、1行である必要があります。改行が入ってしまうと動作しません。コピー＆ペーストの際に改行が入っていないことを確認してください。


## one more thing

こちらは、Markdownのリンク形式でコピーするバージョンです。

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?')){const hq=u.hash.split('?');const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+'?'+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return '[' +document.title+']('+CLEAN(u)+')'}catch(e){return '[' +document.title+']('+location.href+')'}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData('text/plain',txt);ok=true};document.addEventListener('copy',onCopy,{once:true});ok=document.execCommand('copy');return ok}catch(e){}try{let ok=false;const ta=document.createElement('textarea');ta.value=txt;ta.setAttribute('readonly','');ta.style.position='fixed';ta.style.top='0';ta.style.left='0';ta.style.opacity='0';document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand('copy');ta.remove();if(ok)return true}catch(e){}prompt('Copy:\n',txt);return false};await copy(text)})();
```

## another one more thing

こちらは、スプレッドシートの並んだ二つ載せるに貼り付けられる形式コピーするバージョンです。

```javascript
javascript:(async()=>{const CLEAN=u=>{const b=new Set(['fbclid','gclid','gclsrc','dclid','msclkid','mibextid','mc_cid','mc_eid','mkt_tok','yclid','_hsenc','_hsmi','igshid','si','ref','ref_src','ref_url','sr_share','share','share_id','utm_id','ved']);const kk=s=>s.toLowerCase();const zap=sp=>{for(const k of Array.from(sp.keys())){const k2=kk(k);if(k2.startsWith('utm_')||b.has(k2)||k2==='wt.mc_id'||k2==='wt.mc_ev')sp.delete(k)}};const p=u.searchParams;zap(p);if(u.hash&&u.hash.includes('?%27)){const hq=u.hash.split(%27?%27);const h=hq[0],q=hq[1];const sp=new URLSearchParams(q);zap(sp);u.hash=sp.toString()?h+%27?%27+sp:h}return u.toString()};const text=(()=>{try{const u=new URL(location.href);return document.title+%27\t%27+CLEAN(u)}catch(e){return document.title+%27\t%27+location.href}})();const copy=async txt=>{try{if(navigator.clipboard&&navigator.clipboard.writeText){await navigator.clipboard.writeText(txt);return true}}catch(e){}try{let ok=false;const onCopy=e=>{e.preventDefault();e.clipboardData.setData(%27text/plain%27,txt);ok=true};document.addEventListener(%27copy%27,onCopy,{once:true});ok=document.execCommand(%27copy%27);return ok}catch(e){}try{let ok=false;const ta=document.createElement(%27textarea%27);ta.value=txt;ta.setAttribute(%27readonly%27,%27%27);ta.style.position=%27fixed%27;ta.style.top=%270%27;ta.style.left=%270%27;ta.style.opacity=%270%27;document.body.appendChild(ta);ta.focus();ta.select();ok=document.execCommand(%27copy%27);ta.remove();if(ok)return true}catch(e){}prompt(%27Copy:\n%27,txt);return false};await copy(text)})();
```
