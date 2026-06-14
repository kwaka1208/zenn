---
title: "EditorConfig の設定"
---

**[EditorConfig](https://editorconfig.org/)** は、エディタやIDEに関係なく、プロジェクト内のコードスタイル（インデントの種類や文字コードなど）を統一するためのツールです。プロジェクトのルートに **`.editorconfig`** というファイルを置くだけで機能します。VS Code、JetBrains IDE、Vim など多くのエディタが対応しており、チームで開発する際に「インデントがバラバラ」「改行コードが混在する」といった問題を防ぐことができます。

## VS Code での対応

VS Code は拡張機能 **EditorConfig for VS Code** をインストールすることで `.editorconfig` を読み込みます。

1. VS Code の拡張機能タブ（サイドバーのアイコン、またはショートカット `Ctrl+Shift+X` / `Cmd+Shift+X`）を開きます。
2. `EditorConfig` と検索し、**EditorConfig for VS Code**（作者: EditorConfig）をインストールします。

JetBrains 系（IntelliJ IDEA、PyCharm など）は標準で対応しているため、追加の設定は不要です。

## 設定ファイルの配置

プロジェクトのルートディレクトリに `.editorconfig` というファイルを作成します。

```
your-project/
├── .editorconfig   ← ここに置く
├── src/
└── README.md
```

ファイル名の先頭にドット（`.`）がついているため、macOS や Linux ではデフォルトで非表示になります。`ls -a` で確認できます。

## サンプル

以下は、Web 開発でよく使われる設定のサンプルです。

```ini
# プロジェクト全体の設定であることを示す（必ずルートに置く）
root = true

# すべてのファイルに適用するデフォルト設定
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Markdown ファイルは末尾のスペースを保持（改行の意味を持つため）
[*.md]
trim_trailing_whitespace = false

# Python ファイルはインデント幅 4 が標準
[*.py]
indent_size = 4

# Makefile はタブ文字が必須
[Makefile]
indent_style = tab
```

## 主な設定項目

| 設定項目 | 説明 | 値の例 |
|---|---|---|
| `root` | これより上位のディレクトリを探索しない | `true` / `false` |
| `charset` | 文字コード | `utf-8` |
| `end_of_line` | 改行コード | `lf`（Mac/Linux）、`crlf`（Windows）|
| `indent_style` | インデントの種類 | `space` / `tab` |
| `indent_size` | インデントのスペース数 | `2` / `4` |
| `insert_final_newline` | ファイル末尾に改行を入れる | `true` / `false` |
| `trim_trailing_whitespace` | 行末の余分なスペースを削除 | `true` / `false` |

`[*]` はすべてのファイルに適用され、`[*.py]` のようにグロブパターンでファイルの種類ごとに設定を上書きできます。
