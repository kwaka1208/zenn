---
title: "Python 仮想環境の構築"
---

仮想環境とは、プロジェクトごとに独立したPythonの実行環境を作る仕組みです。プロジェクトAとプロジェクトBで異なるバージョンのライブラリを使いたい場合でも、仮想環境を使えば互いに干渉しません。

ここでは、高速なパッケージ管理ツール **uv** を使って仮想環境を構築します。

## 1. uv のインストール

### Windows (PowerShell)
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### macOS
```bash
brew install uv
```

### WSL / Linux (Ubuntu)
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

インストール後、ターミナルを再起動してから以下で確認します。

```bash
uv --version
```

## 2. 仮想環境の作成

プロジェクトのディレクトリで以下のコマンドを実行します。

```bash
uv venv
```

実行すると `.venv` というフォルダが作成されます。

## 3. 仮想環境の有効化 (Activate)

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

### macOS / WSL / Linux
```bash
source .venv/bin/activate
```

有効化されると、プロンプトの先頭に `(.venv)` と表示されます。

## 4. パッケージのインストール

仮想環境を有効化した状態で、`uv pip install` でパッケージをインストールします。

```bash
uv pip install requests
```

## 5. 仮想環境の解除 (Deactivate)

OSに関わらず、同じコマンドで解除できます。

```bash
deactivate
```
