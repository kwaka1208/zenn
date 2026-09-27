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
ユーザー名はあとから変更できます。多くの旧リポジトリURLは新しいURLへリダイレクトされますが、プロフィールURLやGitHub Pagesなどは同じ扱いではありません。旧ユーザー名がほかの人に使われた場合なども含め、転送が恒久的に保証されるわけではないため、最初に納得のいく名前を決めておくのがおすすめです。英数字とハイフンが使えます。
:::

登録後、メールアドレスの確認を求められます。届いたメールの案内に従って完了させてください。

---

## 二要素認証を設定する

GitHubでは、コードを投稿するユーザーを対象に二要素認証（2FA）の導入が進められています。表示される案内や期限はアカウントによって異なる場合がありますが、アカウントの乗っ取りを防ぐため、早めに設定してください。

1. 右上のアイコン → **Settings**
2. 左メニューの **Password and authentication**
3. **Two-factor authentication** の項目から設定

認証アプリ（Google AuthenticatorやMicrosoft Authenticatorなど）のほか、画面に表示される利用可能な方法から選びます。GitHubの画面や選択肢は変わることがあるため、その時点の案内に従ってください。

:::message alert
設定時に表示される**リカバリーコード**は、必ず保存してください。スマートフォンを機種変更したり紛失したりしたときに使える、重要な復旧手段のひとつです。普段使う端末とは別の安全な場所に印刷して保管するか、パスワードマネージャーに保存しておきましょう。登録済みのほかの認証方法を使える場合もあるため、常に「唯一の手段」とは限りません。
:::

---

## 認証方式を決める

自分のパソコンからGitHubに接続するには、「自分が本人である」ことを証明する必要があります。主な方法は2つあります。

| 方式 | 特徴 |
|---|---|
| **SSH** | 鍵ファイルを使う。ssh-agentに登録すれば、毎回の入力を減らせる |
| **HTTPS** | PATや認証支援ツールを使う。OSの安全な保管場所と組み合わせられる |

この本では**SSH**を使います。最初の設定に少し手間がかかりますが、一度済ませてしまえば毎回の操作が楽になるからです。

:::details HTTPSを使いたい場合
HTTPSでは、Git Credential ManagerやGitHub CLIなどの認証支援ツールを使うと、認証情報をOSの安全な保管場所へ保存できます。利用できるなら、これらを第一選択にしてください。

- macOS: Keychainと連携するcredential helper、Git Credential Manager、GitHub CLI
- Windows: Git for Windowsに同梱されるGit Credential Manager、GitHub CLI
- Linux: Git Credential Manager、GitHub CLI、デスクトップ環境の安全な資格情報ストア

現在の設定は次のコマンドで確認できます。

```bash
git config --global --get-all credential.helper
```

macOSでKeychainを使う例:

```bash
git config --global credential.helper osxkeychain
```

WindowsでGit Credential Managerを使う例:

```powershell
git config --global credential.helper manager
```

GitHub CLIを使う場合は、インストール後に次のコマンドでブラウザ認証を進められます。

```bash
gh auth login
```

`credential.helper store` は認証情報を平文で保存するため、この本では使いません。GitHubの画面や利用できる認証方法は変更されることがあるため、組織の方針や公式ドキュメントも確認してください。

PATを手動で作る必要がある場合は、GitHubの **Settings** → **Developer settings** → **Personal access tokens** から、対象リポジトリと必要最小限の権限だけを指定します。表示されたトークンをファイルへ平文で保存しないでください。
:::

---

## SSH鍵とは

SSH鍵は、**2つでひと組**のファイルです。

- **秘密鍵**（例: `id_ed25519_github`）: 自分のパソコンに保管する。**絶対に人に渡さない**
- **公開鍵**（例: `id_ed25519_github.pub`）: GitHubに登録する。人に見られても問題ない

イメージとしては、公開鍵が「南京錠」、秘密鍵が「その鍵」です。GitHubに南京錠を預けておき、接続のたびに「この錠を開けられる鍵を持っています」と証明する仕組みです。

---

## 既存の鍵を確認する

すでに鍵を作ったことがあるかもしれません。まず公開鍵の候補を確認します。

macOS / Linux:

```bash
ls -la ~/.ssh
```

Windows（PowerShell 7）:

```powershell
Get-ChildItem -Force ~/.ssh
```

`.pub` が付いた公開鍵と、同じ名前から `.pub` を除いた秘密鍵がそろっているか確認します。ただし、ファイルがあるだけでGitHub用とは限りません。仕事のサーバーや別サービス、別のGitHubアカウントで使っている可能性があります。

公開鍵の指紋とコメントは、次のように確認できます。

```bash
ssh-keygen -lf ~/.ssh/id_ed25519.pub
```

ファイル名は、実際に見つかった公開鍵へ置き換えてください。GitHubの **Settings** → **SSH and GPG keys** に登録済みの鍵と照合し、次をすべて確認できた場合だけ再利用します。

1. 自分が作った鍵で、用途がわかる
2. 公開鍵と対応する秘密鍵が、このパソコンにそろっている
3. その鍵をGitHub認証に使ってよい
4. 別のGitHubアカウント専用の鍵ではない

:::message alert
用途がわからない既存鍵を上書きしたり、別のサービス用の鍵を無断で使い回したりしないでください。判断できない場合は、次の節でGitHub用の別名の鍵を新しく作るのが安全です。
:::

再利用する鍵を決めた場合は、以降の `~/.ssh/id_ed25519_github` を、その秘密鍵のパスへ読み替えてください。

---

## SSH鍵を作る

既存鍵を再利用しない場合は、この本専用の名前で作ります。

macOS / Linux:

```bash
ssh-keygen -t ed25519 -C "taro@example.com" -f "$HOME/.ssh/id_ed25519_github"
```

Windows（PowerShell 7）:

```powershell
ssh-keygen -t ed25519 -C "taro@example.com" -f "$HOME/.ssh/id_ed25519_github"
```

`-C` の後ろは、鍵を見分けるためのコメントです。メールアドレスを入れるのが慣習です。`-f` でGitHub用の保存先を明示しているため、既定名の既存鍵を上書きしません。

すでに同名の鍵がある場合は上書きの確認が表示されます。**上書きせず**、用途を確認するか、`id_ed25519_github_2` など別の名前に変えてください。

続いてパスフレーズを聞かれます。

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

パスフレーズは、秘密鍵を使うときのパスワードにあたります。

:::message
パスフレーズは設定することを推奨します。万一パソコンを盗まれても、秘密鍵だけでは使えなくなるからです。

「毎回入力するのは面倒」という場合は、次の節のssh-agentを使えば入力回数を減らせます。
:::

:::message alert
`.pub` が付いていないほうが秘密鍵です。**この中身は絶対に他人に見せたり、リポジトリにコミットしたりしないでください。** チャットに貼る、スクリーンショットに写す、といった事故も起きがちです。
:::

---

## ssh-agentに鍵を登録する（推奨）

パスフレーズを毎回入力せずに済むよう、ssh-agentという仕組みに鍵を預けます。OSによって起動方法や保存先が異なります。

### macOS

macOS標準のApple版OpenSSHでは、Keychainと連携できます。

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
```

`~/.ssh/config` には次のように書きます。

```:~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  UseKeychain yes
  AddKeysToAgent yes
```

`--apple-use-keychain` と `UseKeychain` はmacOS専用です。ほかのOSでは使いません。

### Windows（PowerShell 7）

WindowsにはWindows OpenSSHのssh-agentサービスがあります。まず、使用しているSSHを確認します。

```powershell
Get-Command ssh
```

この手順では、Windowsの `C:\Windows\System32\OpenSSH\ssh.exe` とssh-agentサービスを組み合わせます。Git for Windows付属のSSHなど別の実装を使う場合は、同じagentと設定を使うように統一してください。異なる実装を混ぜると、登録した鍵が見えないことがあります。

ssh-agentサービスを自動起動にする操作は、**管理者として開いたPowerShell 7** で最初の1回だけ実行します。

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
```

その後、通常のPowerShell 7で鍵を登録します。

```powershell
ssh-add "$HOME/.ssh/id_ed25519_github"
```

`C:\Users\ユーザー名\.ssh\config` には次のように書きます。拡張子は付けません。

```:~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  AddKeysToAgent yes
```

### Linux

デスクトップ環境などがssh-agentを起動済みなら、そのagentへ登録します。

```bash
ssh-add ~/.ssh/id_ed25519_github
```

`Could not open a connection to your authentication agent.` と出る場合は、現在のシェル用に起動してから登録します。

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
```

この `eval` で設定した接続情報は、現在のシェルやログインセッションを終えると使えなくなる場合があります。永続化の方法はディストリビューションやデスクトップ環境によって異なるため、その環境のagent管理方法に従ってください。

`~/.ssh/config` には次のように書けます。

```:~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  AddKeysToAgent yes
```

:::message
`AddKeysToAgent yes` は、接続時に鍵をagentへ追加しやすくする設定です。agent自体をOS起動後も永続化する設定ではありません。
:::

---

## 公開鍵をGitHubに登録する

この本で新しく作った公開鍵の中身を表示します。

macOS / Linux:

```bash
cat ~/.ssh/id_ed25519_github.pub
```

Windows（PowerShell 7）:

```powershell
Get-Content ~/.ssh/id_ed25519_github.pub
```

既存鍵を再利用する場合は、選んだ公開鍵のパスへ置き換えてください。表示された `ssh-ed25519` で始まる1行をすべてコピーします。

:::message
コピーが難しいときは、次のコマンドでクリップボードに直接入れられます。

macOS:

```bash
pbcopy < ~/.ssh/id_ed25519_github.pub
```

Windows（PowerShell 7）:

```powershell
Get-Content ~/.ssh/id_ed25519_github.pub | Set-Clipboard
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

GitHubの画面名や配置は変わることがあります。見つからない場合はSettings内で「SSH keys」を探してください。

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

表示されたフィンガープリントを、GitHubが公開している最新の一覧と照合します。

https://docs.github.com/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints

一致していることを確認できたら、`yes` と入力してEnterを押します。

次のメッセージが出れば成功です。

```
Hi taro! You've successfully authenticated, but GitHub does not provide shell access.
```

「シェルアクセスは提供していません」と書かれていますが、これは正常です。認証が通ったことを意味しています。

:::details 接続できないとき
`Permission denied (publickey).` と出る場合、次を確認してください。

1. 公開鍵（`.pub` のほう）を登録したか。秘密鍵を貼ってしまっていないか
2. 貼り付けた内容が途中で切れていないか
3. `~/.ssh/config` の `IdentityFile` が、選んだ秘密鍵を指しているか
4. 使用中のSSHとssh-agentが同じ組み合わせか
5. 鍵がssh-agentに登録されているか

```bash
ssh-add -l
```

何も表示されなければ、OS別の手順に戻って、選んだ秘密鍵を `ssh-add` してください。

詳しい状況を見たいときは、`-v` を付けて実行すると経過が表示されます。

```bash
ssh -vT git@github.com
```
:::

---

## コミット用のメールアドレスを見直す

第2章「Gitを使う準備」で触れた、メールアドレスの非公開設定をここで行います。

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
- 既存のSSH鍵は用途と登録先を確認してから再利用する
- SSH鍵を作成し、公開鍵をGitHubに登録した
- ssh-agentの使い方はOSやSSH実装によって異なる
- `ssh -T git@github.com` で接続を確認した
- 秘密鍵は絶対に外に出さない
- HTTPSでは平文保存を避け、安全なcredential helperを使う
- コミット用メールアドレスは非公開用に設定できる

---

次の章では、いよいよローカルのリポジトリをGitHubにpushします。
