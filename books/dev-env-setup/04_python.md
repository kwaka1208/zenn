---
title: "Python のインストール"
---

Python は、汎用性の高いプログラミング言語です。

## Windows
1. [Python 公式サイト](https://www.python.org/downloads/windows/)からインストーラーをダウンロードします。
2. インストール時に **"Add Python to PATH"** に必ずチェックを入れてください（これがないと、コマンドプロンプトから `python` コマンドが使えません）。
3. インストール完了後、PowerShell で `python --version` を実行して確認します。

## macOS
Homebrew を使用してインストールします。

```bash
brew install python
```
macOS には標準で `python3` がインストールされていることがありますが、最新版を Homebrew で管理するのが一般的です。

## Linux (Ubuntu)
Ubuntu には通常 Python がプリインストールされています。最新版や開発用のパッケージが必要な場合は以下を実行します。

```bash
sudo apt update
sudo apt install python3 python3-pip
```

## バージョン確認の注意
多くの環境では、`python` ではなく `python3` コマンドを使用します。

```bash
python3 --version
pip3 --version
```
インストールが成功していれば、バージョン番号が表示されます。
