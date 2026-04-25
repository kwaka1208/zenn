---
title: "Python 仮想環境の構築"
---

## 1. 仮想環境の作成
プロジェクトのディレクトリで以下のコマンドを実行します。

```bash
# Windows (PowerShell) の場合
python -m venv .venv

# macOS / Linux / WSL の場合
python3 -m venv .venv
```

## 2. 仮想環境の有効化 (Activate)

### Windows (PowerShell)
```powershell
.\.venv\Scripts\Activate.ps1
```

:::message
`Activate.ps1` の実行時に「スクリプトの実行が無効になっている」というエラーが表示された場合は、以下のコマンドで実行ポリシーを変更してから再試行してください。

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
:::

### macOS / Linux / WSL
```bash
source .venv/bin/activate
```

## 3. 仮想環境の解除 (Deactivate)
どの環境でも共通のコマンドです。

```bash
deactivate
```
