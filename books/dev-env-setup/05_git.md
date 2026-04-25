---
title: "Git のインストール"
---

Git は、コードの変更履歴を記録するためのツールです。

## Windows (PowerShell)
Windows ネイティブ環境では **Git for Windows** をインストールします。

**winget を使う方法（推奨）**

```powershell
winget install Git.Git
```

**インストーラーを使う方法**

1. [Git for Windows 公式サイト](https://gitforwindows.org/)からインストーラーをダウンロードして実行します。
2. 設定は基本的にデフォルトのままで問題ありません。

インストール後、PowerShell を開き、以下のコマンドでバージョンが表示されるか確認します。

```powershell
git --version
```

### Windows 標準の SSH を使う設定（推奨）

Git for Windows には独自の SSH クライアントが含まれていますが、Windows に組み込まれている OpenSSH を使うように設定しておくと、SSH キーの管理が一元化されて便利です。

```powershell
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

設定後は `ssh-keygen` などの Windows 標準の SSH ツールで生成したキーがそのまま Git でも利用できます。

## Windows (WSL) / Linux (Ubuntu)
WSL または Linux のターミナルで以下のコマンドを実行します。

```bash
sudo apt update
sudo apt install git -y
```

## macOS
前章でインストールした Homebrew を使います。

```bash
brew install git
```

## 初期設定
インストールが完了したら、自分の名前とメールアドレスを登録しましょう。

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```
