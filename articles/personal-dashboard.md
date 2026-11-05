---
title: "GitHub Pages＋Firebaseで作る、自分専用のダッシュボード"
emoji: "🧭"
type: "tech"
topics: ["firebase", "githubpages", "javascript", "css", "dashboard"]
published: false
---

日々の作業がブラウザベースになった時から、よく見る情報、よく使うページやドキュメントへのアクセスをひとまとめにしたいと思いあれこれ試していましたが自分に合うものがありませんでした。

今はAIを使えばどんなものでも作れるようになったので、それなら自分で作ってしまおう、自分で作れば好きな機能が入れられるしサービス終了の心配もない。ということで、自分専用のダッシュボードを作りましたが、きっと他にも需要があると思うので公開することにしました。

100%AI madeのオープンソースダッシュボードシステムです。

## ダッシュボードとは

ダッシュボードとは、自分がよく見る情報やよく使う機能を、1 つの画面にまとめたページのことです。もともとは車の運転席にある計器盤（スピードメーターや燃料計が並んだ部分）を指す言葉で、そこから「必要な情報をひと目で確かめられる画面」という意味で使われるようになりました。

たとえば朝パソコンを開いたとき、今日の予定はカレンダー、やることは ToDo アプリ、天気は天気予報のサイトと、別々の場所で確かめている方も多いと思います。それらを 1 つの画面に並べておけば、ブラウザを開くだけでまとめて確認できます。

ブラウザで使える「自分専用のダッシュボード」をテンプレートとして公開しました。リンク集・ToDo・メモ・Google カレンダー・天気などのウィジェットを並べた画面で、中身は Google アカウントでログインした本人しか見られません。サーバーは持たず、GitHub Pages と Firebase の無料枠だけで動きます。

https://github.com/kwaka1208/personal-dashboard

リポジトリを「Use this template」でコピーし、自分の Firebase プロジェクトをつなげば、15〜20 分ほどで自分のダッシュボードが立ち上がります。この記事では、何ができるのか、どういう構成で「公開リポジトリなのに中身は守られる」のかを紹介します。

## できること：14 種類のウィジェットをドラッグで並べる

画面はウィジェットをマス目に並べたものです。右上の「編集」を押すと、見出し左の ⠿ をドラッグして並べ替えたり、幅（S〜XL）と高さ（1〜4 段）を変えたりできます。用意したウィジェットは次の 14 種類です。

| 種類 | 内容 |
|---|---|
| リンク集 | リスト表示かタイル表示。アイコンは絵文字・画像 URL・ファビコンから選ぶ |
| ToDo | 「仕事」「プライベート」のようにカテゴリーごとに管理 |
| メモ | Markdown で書ける。表示中のチェックボックスをクリックすると元の `[ ]` も書き換わる |
| Google カレンダー / Gmail | 数日分の予定 / 未読件数 |
| 天気 | Open-Meteo から取得（API キー不要） |
| タイマー・ポモドーロ | 終了時に通知と音 |
| 世界時計 / 時計 | 複数都市の時刻と時差 / 現在時刻 |
| 習慣トラッカー | 毎日の記録と連続日数 |
| GitHub | レビュー依頼・自分の PR・担当 Issue |
| 写真 | 画像 URL のスライドショー。Google ドライブや Dropbox の共有リンクも貼れる |
| Web 検索 | 検索 URL を変えれば社内 Wiki や GitHub 検索にも |
| 埋め込み | webページのURLを貼るだけでページを埋め込めます。埋め込みに対応していないページもあります。YouTubeの埋め込みを想定していれた機能です |

特に便利なのが、リンクの追加方法です。ブラウザのアドレスバーにある URL を、そのままリンク集ウィジェットの上へドラッグして離すと登録されます。編集モードに入る必要もありません。「あとで開くページ」を置いておく場所として、ブックマークより気軽に使えます。

このほか、「仕事」「プライベート」のようにタブで画面を分けられ、URL の `#タブID` で特定のタブをブックマークできます。上部の検索欄は `/` キーで移動し、Enter で絞り込んだ先頭のリンクを開きます。

## 構成：画面は GitHub Pages、データは自分の Firebase

構成は単純で、ビルドもありません。`public/` フォルダの HTML・CSS・JavaScript を GitHub Actions で GitHub Pages に公開し、ログインとデータ保存だけを Firebase に任せています。

```
ブラウザ ──▶ GitHub Pages（画面：HTML / CSS / JavaScript）
   │
   ├──▶ Firebase Authentication（Google でログイン）
   └──▶ Cloud Firestore（ダッシュボードのデータ。本人だけ読み書きできる）
```

費用は、GitHub Pages・Firebase Authentication・Firestore の無料プラン（Spark）で足ります。Firebase にクレジットカードを登録する必要もありません。

ダッシュボード全体は 1 つの JSON 文字列として、Firestore の `dashboards/{ユーザーID}` ドキュメントに保存します。編集すると 800 ミリ秒待ってから自動保存するので、PC で並べ替えた結果がそのままスマホにも反映されます。同じ JSON を設定画面から書き出し・読み込みできるので、バックアップや、人のレイアウトを取り込むのにも使えます。

外部ライブラリは、並べ替えの SortableJS、Markdown 変換の marked、危険な HTML を取り除く DOMPurify の 3 つだけで、CDN に頼らずリポジトリに同梱しています。

## リポジトリは公開でも、中身はセキュリティルールで守る

GitHub の無料プランでは、GitHub Pages は Public リポジトリからしか公開できません。そこで、リポジトリに入るのは「画面のプログラム」だけにして、登録したリンクやメモはすべて Firestore 側に置く設計にしました。

| 誰でも見られるもの | ログインした本人しか見られないもの |
|---|---|
| ログイン画面と、画面のプログラム | 登録したリンク、メモ、ウィジェットの並び |
| `firebase-config.js` に書く Firebase の設定値 | ダッシュボードの名前、テーマ、埋め込みの URL |

データを守っているのは Firestore のセキュリティルールです。条件は「ログインしていて、自分のドキュメントで、許可したメールアドレスであること」の 3 つです。

```js:firestore.rules（抜粋）
function allowedEmails() {
  return ['you@example.com'];
}

function isOwner(uid) {
  return request.auth != null
    && request.auth.uid == uid
    && request.auth.token.email_verified == true
    && request.auth.token.email.lower() in allowedEmails();
}

match /dashboards/{uid} {
  allow read, delete: if isOwner(uid);
  allow create, update: if isOwner(uid) && isValidDashboard();
}
```

他人が Google アカウントでログインすること自体はできますが、`allowedEmails()` に入っていなければデータは 1 件も読めません。書き込み時には、フィールドが `json` と `updatedAt` だけであること、JSON が 500KB 未満であること、`updatedAt` がサーバー時刻であることも確認しています。

`apiKey` を公開リポジトリにコミットすると、GitHub のシークレットスキャンから「Publicly leaked secret」という警告が届きます。Firebase のウェブ用 API キーは画面に埋め込んで公開する前提の値なので、それ自体は問題になりません。README では、Google Cloud コンソールでキーを使えるサイト（`<ユーザー名>.github.io` など）と API（ログインと Firestore の 3 つ）に制限してから、警告を「Won't fix」で閉じればOK。

Google カレンダーと Gmail のウィジェットは、ログイン時にもらう OAuth の権限で Google の API を呼びます。Gmail は `gmail.labels` スコープだけを使うので、読めるのは未読件数までで、本文や件名は読めません。アクセストークンや GitHub のトークンはその端末のブラウザにだけ保存し、Firestore には入れません。

## 見た目は CSS 変数とカスケードレイヤーで着せ替える

設定画面には「標準」「グラス」「ブルータル」「ターミナル」「エディトリアル」「和紙」など 9 つのテーマがあり、それぞれにライト／ダークと表示密度を組み合わせられます。

自分好みに変えたいときは、CSS を書き換えます。CSS は役割ごとにファイルを分け、カスケードレイヤー（`@layer`）で優先順位を固定しました。

```
tokens  <  base  <  layout  <  components  <  themes  <  custom
```

いちばん後ろの `custom.css` は最初は空のファイルで、ここに書いたものは詳細度に関係なく他のどの CSS にも勝ちます。見た目のほとんどは CSS 変数で決まっているので、変数を上書きするだけで大きく変わります。

```css:public/css/custom.css
@layer custom {
  :root {
    /* light-dark(ライトモードの色, ダークモードの色) */
    --color-accent: light-dark(#7a3fb0, #c9a2f0);
    --grid-columns: 5;
    --font-heading: var(--font-serif);
  }
}
```

色だけでなく、カードの枠線や影、ホバー時のずらし量、見出しの前に付ける文字（ターミナル風の `"> "` など）まで変数にしてあります。既存の 9 テーマも、この変数を上書きしているだけです。

## テンプレート方式にした理由

このリポジトリはフォークではなく、テンプレートとして使う前提にしています。理由は、利用者ごとに Firebase の設定値と許可するメールアドレスが違い、それぞれが自分の Firebase プロジェクトを持つ形にしたかったからです。データは各自の Firebase に保存され、テンプレートの作者を含め、他の利用者からは見えません。

テンプレートから作ったリポジトリは本家と履歴がつながっていないので、更新を取り込むときは `upstream` を登録してマージします。

```bash
git remote add upstream https://github.com/kwaka1208/personal-dashboard.git
git fetch upstream
git merge upstream/main --allow-unrelated-histories
```

カスタマイズを `custom.css` と `themes.css` への追記にとどめておけば、衝突はほぼ `firebase-config.js` だけで済みます。本家側は `custom.css` を空のまま保つ方針です。

## 試してみるには

手順は README に、Firebase コンソールのどこを押すかまで書いてあります。おおまかな流れは次のとおりです。

1. 「Use this template」で自分のリポジトリを作る（Public）
2. Settings → Pages の Source を「GitHub Actions」にする
3. Firebase プロジェクトを作り、Google ログインを有効にする
4. Firestore を作り、`firestore.rules` を自分のメールアドレスに書き換えて公開する
5. `public/js/firebase-config.js` の `YOUR_...` の 6 つの値を書き換えてコミットする
6. Firebase の承認済みドメインに `<ユーザー名>.github.io` を追加する

Firebase を設定する前でも、`public/` を `python3 -m http.server` で配信すれば「ローカルモード」で動きます。この場合データはブラウザの localStorage にだけ保存されるので、見た目やウィジェットを先に確かめてから Firebase に進むこともできます。

ライセンスは MIT です。自分用のダッシュボードを持ちたい方は、ぜひテンプレートから作ってみてください。
