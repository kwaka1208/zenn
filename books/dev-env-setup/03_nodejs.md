---
title: "Node.js のインストール"
---

Node.js は JavaScript をサーバーや PC 上で動かすための実行環境です。プロジェクトごとに Node.js のバージョンを切り替える必要があるため、バージョン管理ツールを使用することを強く推奨します。ここでは、高速でクロスプラットフォーム対応の **fnm (Fast Node Manager)** を使用する方法を紹介します。

## 1. fnm のインストール

### Windows
PowerShell で以下のコマンドを実行します。
```powershell
winget install Schniz.fnm
```
その後、`$PROFILE` に設定を追加する必要があります。

### macOS / Linux
Homebrew を使用してインストールします。
```bash
brew install fnm
```

## 2. シェルへの設定追加
インストール後、各 OS のシェルの設定ファイル（`.zshrc`, `.bashrc`, または PowerShell の `$PROFILE`）に以下の行を追加してください。

```bash
# zsh/bash の場合
eval "$(fnm env --use-on-cd)"
```

## 3. Node.js のインストール
`fnm` が使えるようになったら、最新の LTS (推奨版) をインストールします。

```bash
# 最新の LTS をインストール
fnm install --lts

# インストールしたバージョンを使用
fnm use lts-latest
```

## 4. バージョンの確認
以下のコマンドで、Node.js と npm（パッケージマネージャー）が正しくインストールされたか確認します。

```bash
node -v
npm -v
```
