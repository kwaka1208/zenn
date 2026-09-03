---
title: GitHubのアカウントとSSH鍵の準備
---

ここからはGitHubを使います。この章では、アカウントを作り、自分のパソコンからGitHubに安全に接続できるようにします。

---

## GitHubアカウントを作る

ブラウザで次のページを開きます。

https://github.com/signup

必要なのは3つだけです。

1. **メールアドレス**: 確認コードが届くので、受け取れるものを使います
2. **パスワード**: 使い回しは避けてください
3. **ユーザー名**: URLの一部になります（`github.com/ユーザー名`）

:::message
ユーザー名は、あとから変更できますが、**変更すると過去のリポジトリURLが変わります**。他の人が参照していたリンクが切れるため、最初に納得のいくものを決めておくのがおすすめです。英数字とハイフンが使えます。
:::

登録後、メールアドレスの確認を求められます。届いたメールの案内に従って完了させてください。

---

## 二要素認証を設定する

GitHubでは二要素認証（2FA）の設定が必須になっています。アカウントを乗っ取られると、公開しているコードを改ざんされる可能性があるため、必ず設定してください。

1. 右上のアイコン → **Settings**
2. 左メニューの **Password and authentication**
3. **Two-factor authentication** の項目から設定

認証アプリ（Google AuthenticatorやMicrosoft Authenticatorなど）を使う方法が一般的です。

:::message alert
設定時に表示される**リカバリーコード**は、必ず保存してください。スマートフォンを機種変更したり紛失したりしたときに、アカウントに入る唯一の手段になります。印刷するか、パスワードマネージャーに保存しておきましょう。
:::

---

## 認証方式を決める

自分のパソコンからGitHubに接続するには、「自分が本人である」ことを証明する必要があります。方法は2つあります。

| 方式 | 特徴 |
|---|---|
| **SSH** | 鍵ファイルを使う。一度設定すれば、以降はパスワード入力不要 |
| **HTTPS** | アクセストークンを使う。設定は簡単だが、トークンの管理が必要 |

この本では**SSH**を使います。最初の設定に少し手間がかかりますが、一度済ませてしまえば毎回の操作が楽になるからです。

:::details HTTPSを使いたい場合
HTTPSでは、パスワードの代わりに**パーソナルアクセストークン（PAT）** を使います。

1. GitHubの Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token** をクリック
3. `repo` にチェックを入れて生成
4. 表示されたトークンをコピー（**この画面を閉じると二度と見られません**）

pushするときにパスワードを聞かれたら、このトークンを貼り付けます。毎回入力しなくて済むよう、次の設定をしておくと便利です。

```bash
git config --global credential.helper store
```

ただしこの方法では、トークンが平文でパソコンに保存されます。OSごとに用意されている安全な保管場所を使うほうがおすすめです。

macOS:

```bash
git config --global credential.helper osxkeychain
```

Windows（PowerShell 7）:

```powershell
git config --global credential.helper manager
```

`manager` はGit for Windowsに同梱されているGit Credential Managerのことで、トークンをWindowsの資格情報マネージャーに保管します。
:::

---

## SSH鍵とは

SSH鍵は、**2つでひと組**のファイルです。

- **秘密鍵**（`id_ed25519`）: 自分のパソコンに保管する。**絶対に人に渡さない**
- **公開鍵**（`id_ed25519.pub`）: GitHubに登録する。人に見られても問題ない

イメージとしては、公開鍵が「南京錠」、秘密鍵が「その鍵」です。GitHubに南京錠を預けておき、接続のたびに「この錠を開けられる鍵を持っています」と証明する仕組みです。

---

## 既存の鍵を確認する

すでに鍵を作ったことがあるかもしれません。まず確認します。

macOS / Linux:

```bash
ls -la ~/.ssh
```

Windows（PowerShell 7）:

```powershell
ls -Force ~/.ssh
```

`id_ed25519` と `id_ed25519.pub` があれば、作成済みです。次の節は飛ばして「公開鍵をGitHubに登録する」へ進んでください。

次のように「そんなファイルやフォルダはない」と出た場合は、これから作ります。

macOS / Linux:

```
No such file or directory
```

Windows（PowerShell 7）:

```
パス 'C:\Users\taro\.ssh' が存在しないため検出できません。
```

---

## SSH鍵を作る

```bash
ssh-keygen -t ed25519 -C "taro@example.com"
```

`-C` の後ろは、鍵を見分けるためのコメントです。メールアドレスを入れるのが慣習です。

実行すると3つ質問されます。

```
Enter file in which to save the key (/Users/taro/.ssh/id_ed25519):
```

保存先です。**そのままEnter**でかまいません。Windowsでは `C:\Users\taro/.ssh/id_ed25519` のように表示されます。

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

パスフレーズです。秘密鍵を使うときのパスワードにあたります。

:::message
パスフレーズは設定することを推奨します。万一パソコンを盗まれても、秘密鍵だけでは使えなくなるからです。

「毎回入力するのは面倒」という場合は、次の節の ssh-agent を使えば、1度入力するだけで済むようになります。
:::

完成すると、次のように表示されます。

```
Your identification has been saved in /Users/taro/.ssh/id_ed25519
Your public key has been saved in /Users/taro/.ssh/id_ed25519.pub
```

Windowsでは、パスの部分が `C:\Users\taro/.ssh/...` のようになります。

:::message alert
`.pub` が付いていないほう（`id_ed25519`）が秘密鍵です。**この中身は絶対に他人に見せたり、リポジトリにコミットしたりしないでください。** チャットに貼る、スクリーンショットに写す、といった事故も起きがちです。
:::

---

## ssh-agentに鍵を登録する（推奨）

パスフレーズを毎回入力せずに済むよう、ssh-agentという仕組みに鍵を預けます。

macOS / Linux:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Windows（PowerShell 7）:

Windowsでは、ssh-agentがWindowsのサービスとして用意されています。パソコンの起動時に自動で立ち上がるようにしてから、鍵を登録します。

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
ssh-add ~/.ssh/id_ed25519
```

:::message
1行目の `Set-Service` は、Windowsの設定を変更するため**管理者権限**が必要です。「アクセスが拒否されました」と出た場合は、スタートメニューで「PowerShell 7」を右クリックし、「管理者として実行」で開き直してから、1行目と2行目を実行してください。この設定は最初の1回だけで済みます。
:::

さらに、次の設定ファイルを作っておくと、毎回 `ssh-add` する必要がなくなります。

macOS:

```:~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  UseKeychain yes
  AddKeysToAgent yes
```

Windows（PowerShell 7）/ Linux:

```:~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
```

:::message
`UseKeychain` はmacOS専用の設定なので、WindowsとLinuxでは書きません。書いてしまうと `Bad configuration option` というエラーになります。

Windowsでのこのファイルの置き場所は `C:\Users\ユーザー名\.ssh\config` です。拡張子は付けません。メモ帳で保存すると `config.txt` になってしまうことがあるので、VS Codeなどのエディタで保存してください。
:::

---

## 公開鍵をGitHubに登録する

公開鍵の中身を表示します。

```bash
cat ~/.ssh/id_ed25519.pub
```

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... taro@example.com
```

この1行をすべてコピーします。

:::message
コピーが難しいときは、次のコマンドでクリップボードに直接入れられます。

macOS:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

Windows（PowerShell 7）:

```powershell
Get-Content ~/.ssh/id_ed25519.pub | Set-Clipboard
```
:::

ブラウザでGitHubを開き、次の手順で登録します。

1. 右上のアイコン → **Settings**
2. 左メニューの **SSH and GPG keys**
3. **New SSH key** ボタンをクリック
4. **Title**: どのパソコンの鍵かわかる名前（例: `MacBook Air`）
5. **Key type**: `Authentication Key` のまま
6. **Key**: コピーした内容を貼り付け
7. **Add SSH key** をクリック

---

## 接続を確認する

登録できたか試します。

```bash
ssh -T git@github.com
```

初回は次のように聞かれます。

```
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

`yes` と入力してEnterを押します。

:::message
表示されたフィンガープリントが、GitHubが公開している値と一致しているかを確認するのが本来の作法です。上に示した `SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU` はGitHubのed25519鍵の正しい値です。最新の一覧は次のページで確認できます。

https://docs.github.com/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
:::

次のメッセージが出れば成功です。

```
Hi taro! You've successfully authenticated, but GitHub does not provide shell access.
```

「シェルアクセスは提供していません」と書かれていますが、これは正常です。認証が通ったことを意味しています。

:::details 接続できないとき
`Permission denied (publickey).` と出る場合、次を確認してください。

1. 公開鍵（`.pub` のほう）を登録したか。秘密鍵を貼ってしまっていないか
2. 貼り付けた内容が途中で切れていないか
3. 鍵が ssh-agent に登録されているか

```bash
ssh-add -l
```

何も表示されなければ、`ssh-add ~/.ssh/id_ed25519` を実行してください。

詳しい状況を見たいときは、`-v` を付けて実行すると経過が表示されます。

```bash
ssh -vT git@github.com
```
:::

---

## コミット用のメールアドレスを見直す

第2章で触れた、メールアドレスの非公開設定をここで行います。

1. GitHubの Settings → **Emails**
2. **Keep my email addresses private** にチェック
3. その下に表示される `12345678+ユーザー名@users.noreply.github.com` をコピー

このアドレスをGitに設定します。

```bash
git config --global user.email "12345678+ユーザー名@users.noreply.github.com"
```

これで、今後のコミットには実際のメールアドレスが残らなくなります。

:::message
すでに作ったコミットのメールアドレスは書き換わりません。この本の練習用リポジトリでは気にしなくて構いませんが、公開するプロジェクトでは最初に設定しておくとよいでしょう。
:::

---

## この章のまとめ

- GitHubアカウントを作り、二要素認証を設定した
- SSH鍵を作成し、公開鍵をGitHubに登録した
- `ssh -T git@github.com` で接続を確認した
- 秘密鍵は絶対に外に出さない
- コミット用メールアドレスは非公開用に設定できる

---

次の章では、いよいよローカルのリポジトリをGitHubにpushします。
