---
title: "Git のインストール"
---

Git は、コードの変更履歴を記録するためのツールです。

## Windows (PowerShell / コマンドプロンプト)
Windows ネイティブ環境では **Git for Windows** をインストールします。

1. [Git for Windows 公式サイト](https://gitforwindows.org/)からインストーラーをダウンロードして実行します。
2. 設定は基本的にデフォルトのままで問題ありません。
3. インストール後、ターミナル（PowerShell 等）を開き、以下のコマンドでバージョンが表示されるか確認します。
   ```bash
   git --version
   ```

## Windows (WSL) / Linux (Ubuntu)
WSL または Linux のターミナルで以下のコマンドを実行します。

```bash
sudo apt update
sudo apt install git -y
```

## macOS
Homebrew を使うのが最も簡単です。

```bash
brew install git
```

## 初期設定
インストールが完了したら、自分の名前とメールアドレスを登録しましょう。

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```
