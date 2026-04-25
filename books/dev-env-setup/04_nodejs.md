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
インストール後、`$PROFILE`（設定ファイル）に以下の行を追加してください。
```powershell
fnm env --use-on-cd | Out-String | Invoke-Expression
```

### Windows (WSL) / Linux (Ubuntu)
ターミナルで以下のコマンドを実行します。
```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

### macOS
```bash
brew install fnm
```

## 2. Node.js のインストール
`fnm` が使えるようになったら、最新の LTS をインストールします。

```bash
fnm install --lts
fnm use lts-latest
```

## 3. バージョンの確認
```bash
node -v
npm -v
```
 stone
