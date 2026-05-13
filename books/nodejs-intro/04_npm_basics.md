---
title: "npmで広がるライブラリの世界"
---

Node.jsを使う上で欠かせないのが `npm` (Node Package Manager) です。

## npmとは？
世界中の開発者が作った便利なプログラム（パッケージ）を管理するためのツールです。Node.jsをインストールすると自動的に付いてきます。

## プロジェクトの初期化
新しいプロジェクトを始める際は、まず `package.json` という設定ファイルを作ります。

```bash
npm init -y
```

これにより、プロジェクト名や依存パッケージの情報が書き込まれる `package.json` が作成されます。

## パッケージのインストール
例として、日付操作に便利な `dayjs` をインストールしてみましょう。

```bash
npm install dayjs
```

`node_modules` フォルダと `package-lock.json` が作成されます。

## インストールしたパッケージを使う
`index.js` を作成して、使ってみましょう。

```javascript:index.js
const dayjs = require('dayjs');
console.log(dayjs().format('YYYY-MM-DD'));
```

## 代替パッケージマネージャー：yarn と pnpm
npm以外にも、より高速で効率的なパッケージマネージャーが広く使われています。

### yarn
Facebook（現Meta）によって開発されたツールです。npmよりも早くから「高速化」や「依存関係の固定（yarn.lock）」を導入し、コミュニティで高く支持されています。

### pnpm (推奨)
「Performant npm」の略で、ディスク容量を節約しつつ非常に高速に動作します。同じパッケージを複数のプロジェクトで共有する仕組みがあり、現代のNode.js開発で非常に人気が高まっています。

## どれを使えばいい？
初心者のうちは、標準の npm で十分です。プロジェクトに `yarn.lock` や `pnpm-lock.yaml` が含まれている場合は、そのプロジェクトの指示に従ってツールを使い分けましょう。
