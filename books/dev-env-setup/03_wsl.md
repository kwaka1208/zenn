---
title: "WSL のインストール (Windowsのみ)"
---

Windows で開発を行う場合、Linux 環境を直接実行できる **WSL (Windows Subsystem for Linux)** を利用するのが非常に便利です。

## WSL とは
WSL を使用すると、Windows 上で Ubuntu などの Linux ディストリビューションを動かすことができます。Mac や Linux と同じコマンドが使えるようになるため、開発環境の差異を最小限に抑えられます。

## インストール手順

1. **PowerShell を管理者として実行**します。
   - スタートメニューを右クリックして「ターミナル（管理者）」または「PowerShell（管理者）」を選択します。

2. 以下のコマンドを入力して実行します。
   ```powershell
   wsl --install
   ```

3. **PC を再起動**します。

4. 再起動後、Ubuntu のウィンドウが自動的に開きます。ユーザー名とパスワードの設定を求められるので、任意のものを入力してください。
   - パスワード入力時、文字は表示されませんが入力されています。

## バージョンの確認
インストールが完了したら、PowerShell で以下のコマンドを実行して、WSL 2 がインストールされていることを確認します。

```powershell
wsl -l -v
```

## パッケージの更新
Ubuntu が起動したら、まずはパッケージを最新の状態に更新しておきましょう。

```bash
sudo apt update && sudo apt upgrade -y
```

これで Windows 上に Linux 開発環境が整いました。
