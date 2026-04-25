---
title: "Homebrew のインストール (macOSのみ)"
---

macOS で開発を行う場合、パッケージ管理ツール **Homebrew** を使うとツールのインストールや更新が簡単になります。

## Homebrew とは

Homebrew は macOS 向けのパッケージ管理ツールです。`brew install` コマンド一つで Git や Node.js、Python などの開発ツールをインストールできます。

## インストール手順

1. **ターミナル** を開きます。
   - Finder → アプリケーション → ユーティリティ → ターミナル、または Spotlight（`⌘ + スペース`）で「ターミナル」と検索します。

2. 以下のコマンドを貼り付けて実行します。

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. 途中でパスワードの入力を求められる場合があります。macOS のログインパスワードを入力してください。

4. インストール完了後に以下のコマンドを実行してパスを通します。

   ```bash
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

## バージョンの確認

```bash
brew --version
```

バージョン番号が表示されればインストール完了です。以降の章では `brew install` コマンドを使ってツールをインストールします。
