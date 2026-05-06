---
title: "make コマンドの使い方"
---

**make** は、定型的な作業をコマンド一発で実行できるようにするタスクランナーです。もともとはソースコードのコンパイル自動化のために作られたツールですが、現在はサーバーの起動、テストの実行、ファイルの生成など、あらゆる繰り返し作業の自動化に広く使われています。

プロジェクトのルートに `Makefile` というファイルを置き、`make <タスク名>` で実行します。

## インストール

### Windows

Windows には `make` が標準搭載されていないため、別途インストールが必要です。

**winget を使う方法（推奨）**

管理者権限の PowerShell で以下を実行します。

```powershell
winget install GnuWin32.Make
```

インストール後、`C:\Program Files (x86)\GnuWin32\bin` を PATH に追加してください（PATH の追加方法は前章を参照）。

**Chocolatey を使う方法**

[Chocolatey](https://chocolatey.org/) がインストール済みの場合は以下で導入できます。

```powershell
choco install make
```

**WSL を使う方法**

WSL 環境では Linux と同じ手順でインストールできます（次項参照）。WSL を使っている場合はこちらが最も手軽です。

### Windows (WSL) / Linux (Ubuntu)

```bash
sudo apt update
sudo apt install make -y
```

### macOS

Xcode Command Line Tools に含まれています。Git のインストール時点で導入済みのことがほとんどです。未インストールの場合は以下を実行します。

```bash
xcode-select --install
```

### バージョン確認

```bash
make --version
```

## Makefile の書き方

`Makefile` はプロジェクトのルートディレクトリに置きます。

```makefile
# ターゲット名: 依存ターゲット
#<タブ>実行するコマンド

install:
	npm install

start:
	npm run dev

test:
	npm test

build:
	npm run build

clean:
	rm -rf dist node_modules
```

> **注意**: コマンドの行頭はスペースではなく **タブ文字** でなければなりません。スペースで書くとエラーになります。エディタの設定で `Makefile` はタブ文字を使うよう設定しておきましょう（`.editorconfig` のサンプルも参照）。

## 使い方

```bash
make install    # npm install を実行
make start      # 開発サーバーを起動
make test       # テストを実行
make build      # ビルドを実行
make clean      # 生成ファイルを削除
```

引数なしで `make` を実行すると、Makefile の最初のターゲットが実行されます。

## よく使うテクニック

### .PHONY でファイル名との衝突を防ぐ

`make` はもともとファイル生成ツールのため、`test` や `clean` という名前のファイルが存在すると「最新のファイルがある」と判断してコマンドを実行しません。ファイル生成を伴わないタスクには `.PHONY` を宣言しておくのが無難です。

```makefile
.PHONY: install start test build clean

install:
	npm install
```

### デフォルトターゲットを明示する

```makefile
.DEFAULT_GOAL := help

help:
	@echo "使用可能なコマンド:"
	@echo "  make install  - 依存パッケージをインストール"
	@echo "  make start    - 開発サーバーを起動"
	@echo "  make test     - テストを実行"
```

行頭に `@` をつけると、実行するコマンド自体は表示せず結果だけ出力されます。

### 変数を使う

```makefile
PYTHON = python3
SRC = src/main.py

run:
	$(PYTHON) $(SRC)
```

## Makefile のサンプル（Python プロジェクト）

```makefile
.PHONY: install run test lint clean

install:
	pip install -r requirements.txt

run:
	python src/main.py

test:
	pytest

lint:
	ruff check .

clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -name "*.pyc" -delete
```
