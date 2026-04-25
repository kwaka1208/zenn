---
title: "Python のインストール"
---

## Windows (PowerShell / コマンドプロンプト)
1. [Python 公式サイト](https://www.python.org/downloads/windows/)からインストーラーをダウンロードします。
2. インストール時に **"Add Python to PATH"** に必ずチェックを入れてください。
3. インストール後、PowerShell で `python --version` を実行して確認します。

## Windows (WSL) / Linux (Ubuntu)
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv -y
```

## macOS
```bash
brew install python
```

## バージョン確認
環境により `python` または `python3` コマンドを使用します。

```bash
python3 --version
# または
python --version
```
