---
title: "Python 仮想環境の構築"
---

## 1. 仮想環境の作成
プロジェクトのディレクトリで以下のコマンドを実行します。

```bash
# Windows (PowerShell/CMD) の場合
python -m venv .venv

# macOS / Linux / WSL の場合
python3 -m venv .venv
```

## 2. 仮想環境の有効化 (Activate)

### Windows (PowerShell)
```powershell
.\.venv\Scripts\Activate.ps1
```

### Windows (コマンドプロンプト)
```cmd
.venv\Scripts\activate.bat
```

### macOS / Linux / WSL
```bash
source .venv/bin/activate
```

## 3. 仮想環境の解除 (Deactivate)
どの環境でも共通のコマンドです。

```bash
deactivate
```
 stone
