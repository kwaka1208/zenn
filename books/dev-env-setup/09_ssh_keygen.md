---
title: "SSH キーペアの作成"
---

GitHub などのサービスに SSH で接続するには、**SSH キーペア**（秘密鍵と公開鍵のペア）が必要です。

## SSH キーペアとは

SSH キーペアは2つのファイルで構成されます。

- **秘密鍵**（例: `id_ed25519`）: 自分のマシンだけに保管し、絶対に外部に漏らさないファイル
- **公開鍵**（例: `id_ed25519.pub`）: GitHub などのサービスに登録するファイル

## Windows での事前確認

Windows では OpenSSH クライアントに `ssh-keygen` が含まれています。PowerShell で以下のコマンドを実行してインストール状況を確認してください。

```powershell
Get-WindowsCapability -Online -Name OpenSSH.Client*
```

`State : Installed` と表示されていればそのまま使えます。`State : NotPresent` の場合は以下でインストールしてください。

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

:::message
Windows 11 では多くの場合デフォルトでインストール済みです。
:::

## キーペアの作成

すべての環境（Windows PowerShell / macOS / Linux / WSL）で共通のコマンドです。

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

`-C` オプションのメールアドレスはキーの識別用コメントです。GitHub に登録しているメールアドレスを指定するのが一般的です。

実行すると以下のように確認が求められます。

```
Enter file in which to save the key (/home/user/.ssh/id_ed25519):
```

保存先を変更しない場合はそのまま Enter を押してください。

```
Enter passphrase (empty for no passphrase):
```

パスフレーズを設定するとキーの使用時にパスワード入力が求められます。セキュリティのために設定を推奨します。

## ssh-agent への登録

毎回パスフレーズを入力しなくて済むよう、ssh-agent に秘密鍵を登録します。

### Windows (PowerShell)

ssh-agent サービスを有効化してから登録します。

```powershell
Get-Service ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

### macOS

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

### Linux / WSL

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## 公開鍵の確認

以下のコマンドで公開鍵の内容を表示できます。

### Windows (PowerShell)

```powershell
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
```

### macOS / Linux / WSL

```bash
cat ~/.ssh/id_ed25519.pub
```

表示された `ssh-ed25519 AAAA...` から始まる文字列全体を GitHub 等のサービスに登録してください。

## 接続確認（GitHub の場合）

公開鍵をサービスに登録した後、以下のコマンドで接続を確認します。

```bash
ssh -T git@github.com
```

`Hi username! You've successfully authenticated.` と表示されれば成功です。
