---
title: GmailでGmail以外のアドレスのメールを送受信する
emoji: "✉️"
type: idea
topics: [gmail]
published: true
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

## 設定手順
1. Gmailの設定（歯車のアイコン）をクリックし「すべての設定を表示」→「アカウントとインポート」を選択します。

2. 「アカウントとインポート」の中にある「他のアカウントのメールを確認」と言う欄がありますので「他のメールアドレスを追加」をクリックします。  
![](/images/use-alternate-mail-address-via-gmail/02.png)

3. 別ウインドウが開きますので（ポップアップブロックで開かない場合は解除してください）メールアドレスを入力して「次へ」をクリックします。
![](/images/use-alternate-mail-address-via-gmail/03.png)

4. 「他のアカウントからメールを読み込む（POP3）」選択し「次へ」をクリックします。  
![](/images/use-alternate-mail-address-via-gmail/04.png)

5. 受信元メールアドレスのメール受信情報を入力します。ポート番号を間違いやすいのでご注意ください。チェックボックスの部分は受信元サーバーの設定ならびに自分の運用に合わせて設定してください。
![](/images/use-alternate-mail-address-via-gmail/05.png)

6. メールサーバーへの接続が成功すると以下のメッセージが表示されます。同じメールアドレスで送信可能にするためには「はい」を選んで次へ進みます。必要がない方はここで「いいえ」を選んでください、ここで終了です。
![](/images/use-alternate-mail-address-via-gmail/06.png)

7. 送信者名を入力し、「エイリアスとして扱います」にチェックを入れて「次へ」をクリックします。
![](/images/use-alternate-mail-address-via-gmail/07.png)

８. メールの送信設定を行います。設定内容はプロバイダとの契約情報などを参照してください。
![](/images/use-alternate-mail-address-via-gmail/08.png)

9. 送信設定を正しく設定すると以下のメッセージが表示され、確認メールが送られます。
![](/images/use-alternate-mail-address-via-gmail/09.png)

10. 「Gmailからのご確認 mail@example.com を差出人としてメールを送信します」というメールが届きますので、リンクをクリックして確認を行います。
![](/images/use-alternate-mail-address-via-gmail/10.png)

11. 以下のメッセージが表示されますので「確認」をクリックします。
![](/images/use-alternate-mail-address-via-gmail/11.png)

12. 確認が完了すると以下のメッセージが表示されます。
![](/images/use-alternate-mail-address-via-gmail/12.png)

13. Gmailの設定の「アカウントとインポート」の中にある「他のアカウントのメールを確認」欄に、メールアドレスが追加されています。「メールを今すぐ確認する」をクリックするとメールの受信が行われます。
![](/images/use-alternate-mail-address-via-gmail/13.png)

14. メールの送信画面で差出人のメールアドレスをクリックすると、先ほど追加したメールアドレスが選択できるようになります。
![](/images/use-alternate-mail-address-via-gmail/14.png)

以上で完了です。
