---
title: "Node.js のインストール"
---

Node.js のバージョン管理ツール **fnm (Fast Node Manager)** を使用する方法を紹介します。

## 1. fnm のインストール

### Windows (PowerShell)
管理者権限の PowerShell で以下のコマンドを実行します。
```powershell
winget install Schniz.fnm
```
インストール後、**PowerShell 7 (pwsh)** で以下のコマンドを実行してください。`$PROFILE`（PowerShell 7 の設定ファイル）に必要な行を追記します。

```powershell
New-Item -Path (Split-Path $PROFILE) -ItemType Directory -Force | Out-Null
Add-Content $PROFILE 'fnm env --use-on-cd | Out-String | Invoke-Expression'
```

実行後、PowerShell を再起動すると設定が反映されます。

### Windows (WSL) / Linux (Ubuntu)
ターミナルで以下のコマンドを実行します。
```bash
curl -fsSL https://fnm.vercel.app/install | bash
```
インストールスクリプトが自動的にシェル設定を行いますが、反映されない場合は `~/.bashrc` に以下の行を追加してください。
```bash
eval "$(fnm env --use-on-cd)"
```

### macOS
前章でインストールした Homebrew を使います。
```bash
brew install fnm
```
インストール後、使用しているシェルの設定ファイルに以下の行を追加してください。

- **zsh**（デフォルト）: `~/.zshrc`
- **bash**: `~/.bash_profile`

```bash
eval "$(fnm env --use-on-cd)"
```

追加後、ターミナルを再起動するか `source ~/.zshrc`（または `source ~/.bash_profile`）を実行してください。

## 2. Node.js のインストール
`fnm` が使えるようになったら、最新の LTS をインストールします。

```bash
fnm install --lts
fnm use --lts
```

## 3. バージョンの確認
```bash
node -v
npm -v
```
