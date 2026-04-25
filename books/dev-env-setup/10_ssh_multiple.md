---
title: "Git で複数の SSH キーを使い分ける"
---

GitHub の個人アカウントと仕事用アカウントを使い分けたり、GitHub と GitLab を併用する場合は、SSH の設定ファイルでキーを切り替えます。

## 複数のキーペアを作成する

接続先ごとに別々のキーペアを作成します。保存先のファイル名を変えて区別してください。

### Windows (PowerShell)

```powershell
# 個人用
ssh-keygen -t ed25519 -C "personal@example.com" -f "$env:USERPROFILE\.ssh\id_ed25519_personal"

# 仕事用
ssh-keygen -t ed25519 -C "work@example.com" -f "$env:USERPROFILE\.ssh\id_ed25519_work"
```

### macOS / Linux / WSL

```bash
# 個人用
ssh-keygen -t ed25519 -C "personal@example.com" -f ~/.ssh/id_ed25519_personal

# 仕事用
ssh-keygen -t ed25519 -C "work@example.com" -f ~/.ssh/id_ed25519_work
```

作成した各公開鍵（`.pub` ファイル）を、それぞれのサービスのアカウントに登録します。

## SSH 設定ファイルを作成する

以下の内容で設定ファイルを作成します。

- **Windows**: `$env:USERPROFILE\.ssh\config`
- **macOS / Linux / WSL**: `~/.ssh/config`

接続先ごとに使用するキーを指定します。

```
Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
```

`Host` に指定した名前（`github-personal` など）は任意の識別子です。

## 接続確認

設定ファイルに書いた `Host` 名で接続を確認します。

```bash
ssh -T git@github-personal
ssh -T git@github-work
```

それぞれ対応するアカウント名で認証成功のメッセージが表示されれば設定完了です。

## リポジトリで使用するキーを指定する

リモートURLの `github.com` の部分を、`config` に設定した `Host` 名に書き換えます。

```bash
# クローン時
git clone git@github-personal:username/repo.git

# 既存リポジトリのリモートURLを変更する場合
git remote set-url origin git@github-work:org/repo.git
```

## リポジトリごとにユーザー情報を切り替える

コミットに記録される名前とメールアドレスも、リポジトリごとに変更できます。

```bash
git config user.name "Work Name"
git config user.email "work@example.com"
```

`--global` を付けないことでそのリポジトリにのみ適用されます。
