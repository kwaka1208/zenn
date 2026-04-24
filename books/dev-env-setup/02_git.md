---
title: "Git のインストール"
---

Git は、コードの変更履歴を記録するためのツールです。

## Windows
Windows では **Git for Windows** をインストールするのが一般的です。

1. [Git for Windows 公式サイト](https://gitforwindows.org/)からインストーラーをダウンロードして実行します。
2. 設定は基本的にデフォルトのままで問題ありません。
3. インストール後、`Git Bash` または `PowerShell` を開き、以下のコマンドでバージョンが表示されるか確認します。
   ```bash
   git --version
   ```

## macOS
macOS では、Homebrew を使うのが最も簡単です。

1. **Homebrew** がインストールされていない場合は、[公式サイト](https://brew.sh/)の指示に従ってインストールしてください。
2. ターミナルで以下のコマンドを実行します。
   ```bash
   brew install git
   ```

## Linux (Ubuntu)
パッケージマネージャーを使用してインストールします。

```bash
sudo apt update
sudo apt install git
```

## 初期設定
インストールが完了したら、自分の名前とメールアドレスを登録しましょう。これはコミット（履歴の保存）を行う際に使用されます。

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

設定を確認するには以下のコマンドを実行します。
```bash
git config --list
```
