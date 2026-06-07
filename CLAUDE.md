# Zenn コンテンツリポジトリ

## 概要

[Zenn](https://zenn.dev) に公開する記事・本を管理するリポジトリ。`zenn-cli` を使ってローカルでプレビューしながら執筆する。

## ディレクトリ構成

```
articles/   # 記事（.md）
books/      # 本（ディレクトリごとに1冊）
images/     # 画像ファイル
docs/       # その他ドキュメント
```

## よく使うコマンド

```bash
make preview          # プレビューサーバー起動（http://localhost:8000）
make new slug=記事名   # 新しい記事を作成
npx zenn new:book     # 新しい本を作成
```

## 記事のフロントマター

```yaml
---
title: 記事タイトル
emoji: 🎉
type: tech   # tech（技術）または idea（アイデア）
topics: [タグ1, タグ2]
published: true  # false にすると下書き
---
```

## 本の config.yaml

```yaml
title: 本のタイトル
summary: 概要
topics: [タグ1, タグ2]
published: true
price: 0
chapters:
  - チャプターのスラッグ（拡張子なし）
```

## 執筆ルール

- 対象読者はエンジニア以外の一般ユーザーが多い。難しい用語には説明を添える。
- 本文はです・ます調で統一する。
- 記事スラッグはケバブケース（例: `how-to-do-something`）で英語表記。
- 画像は `images/` に配置し、記事から相対パスで参照する。
- `published: false` で下書き保存してから公開する運用。

## 注意事項

- `node_modules/` は変更しない。
- 既存記事のスラッグ（ファイル名）は変更しない（URLが変わるため）。
