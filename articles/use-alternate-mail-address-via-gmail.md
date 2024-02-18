---
title: GmailでGmail以外のアドレスのメールを送受信する
emoji: "🐍"
type: tech
topics: [gmail]
published: false
---
## 概要
界隈ではあちこちで話題になっていますが、2024年2月に実施されたスパムメール対策により、一定の条件を満たさないメールについてはGmailの受信トレイどこから迷惑メールにすら入らないようになりました。

- [メール送信者のガイドライン](https://support.google.com/a/answer/81126)
- [Gmailユーザへメールが届かなくなる？Googleが発表した「新しいメール送信者のガイドライン」とDMARC対応を解説！](https://www.nri-secure.co.jp/blog/gmail-guideline-2023)
- [なぜGmailだけ届かなかった？　高校出願システム問題、神奈川県に詳しく聞いた](https://www.itmedia.co.jp/news/articles/2402/09/news114.html)

これにより、Gmail以外のアドレスから自分のGmailアドレスにメールを転送して受信しているようなケースでも同様にメールが受け取れないという問題が発生します。

[メール送信者のガイドライン](https://support.google.com/a/answer/81126)に準拠する形での転送ができれば良いのですが、自分で対応できない場合もあるかと思いますので、このような場合にはGmailへ転送するのではなく、Gmailから転送元のメールサーバーへメールを受信するようにすることで回避できます。

![](/images/use-alternate-mail-address-via-gmail/01.png)

この記事では、Gmailを使って、Gmail以外のアドレス宛のメールを受信するための設定と合わせてGmailから別のメールアドレスからのメール送信をするための設定を紹介します。

なお、受信にすると一定の受信間隔ごとでの受信となるため、シビアなリアルタイム性を求められる場合には向いていません。そのようなメールはGmailのアドレスで直接受信するようにしてください。当然ながら、その場合も送信元は[メール送信者のガイドライン](https://support.google.com/a/answer/81126)に準拠していなければ届きませんのでご注意を。

## GmailでGmail以外のアドレスのメールを受信する
1. Gmailの設定（歯車のアイコン）をクリックし「すべての設定を表示」→「アカウントとインポート」を選択します。
2. 「アカウントとインポート」の中にある「他のメールアカウントを確認」と言う欄がありますので「他のメールアドレスを追加」をクリックします。  
![](/images/use-alternate-mail-address-via-gmail/02.png)
3. 別ウインドウが開きますので（ポップアップブロックで開かない場合は解除してください）メールアドレスを入力して「次へ」をクリックします。
![](/images/use-alternate-mail-address-via-gmail/03.png)
4. 「他のアカウントからメールを読み込む（POP3）」選択し「次へ」をクリックします。  
![](/images/use-alternate-mail-address-via-gmail/04.png)
5. 

![](/images/use-alternate-mail-address-via-gmail/05.png)

![](/images/use-alternate-mail-address-via-gmail/06.png)
![](/images/use-alternate-mail-address-via-gmail/07.png)
![](/images/use-alternate-mail-address-via-gmail/08.png)
![](/images/use-alternate-mail-address-via-gmail/09.png)
![](/images/use-alternate-mail-address-via-gmail/10.png)
![](/images/use-alternate-mail-address-via-gmail/11.png)
![](/images/use-alternate-mail-address-via-gmail/12.png)
![](/images/use-alternate-mail-address-via-gmail/13.png)
![](/images/use-alternate-mail-address-via-gmail/14.png)
