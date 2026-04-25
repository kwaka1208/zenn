---
title: "PowerShell 7 のインストール (Windowsのみ)"
---

Windows には標準で **Windows PowerShell 5.1** が搭載されていますが、本書では最新の **PowerShell 7** を使用することを推奨します。

## PowerShell 7 とは

PowerShell 7 は Windows PowerShell の後継となるクロスプラットフォーム版です。起動コマンドが `powershell` から `pwsh` に変わり、パフォーマンスの向上や新機能が追加されています。

:::message
WSL 環境を使う場合も、WSL のインストール手順を PowerShell 7 から実行することを推奨します。
:::

## インストール手順

**winget**（Windows パッケージマネージャー）を使ってインストールします。

1. **Windows PowerShell** または **ターミナル** を開きます（管理者権限は不要です）。

2. 以下のコマンドを実行します。

   ```powershell
   winget install Microsoft.PowerShell
   ```

3. 画面の指示に従ってインストールを完了してください。

## バージョンの確認

インストール後、新しいターミナルウィンドウを開いて以下のコマンドを実行します。

```powershell
pwsh --version
```

`PowerShell 7.x.x` と表示されればインストール完了です。

## Windows ターミナルでの既定シェル設定（任意）

**Windows ターミナル** を使用している場合、既定のシェルを PowerShell 7 に変更しておくと便利です。

1. Windows ターミナルを開き、タブ横の「∨」→「設定」を選択します。
2. 「起動」→「既定のプロファイル」を **PowerShell** （アイコンが黒背景のもの）に変更します。
3. 「保存」をクリックします。

:::message alert
「Windows PowerShell」（青いアイコン）と「PowerShell」（黒いアイコン）は別物です。PowerShell 7 は黒いアイコンの「PowerShell」です。
:::
