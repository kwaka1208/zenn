---
title: "Expressで効率的に開発しよう"
---
前章では `http` モジュールを使ってサーバーを作りましたが、実際の開発では **Express** というフレームワークを使うのが一般的です。

## Expressとは？
Node.jsで最も人気のあるWebアプリケーションフレームワークです。ルーティング（URLごとの処理分け）や、リクエストの解析が非常に簡単になります。

## インストール
```bash
npm install express
```

## Expressでのサーバー作成
`app.js` を作成して、以下のコードを書いてみましょう。

```javascript:app.js
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello Express! より簡単にサーバーが作れました。');
});

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}/`);
});
```

## メリット
- **直感的なルーティング**: `app.get('/about', ...)` のように書くだけでページを増やせます。
- **ミドルウェア**: 認証やログ出力などの共通処理を簡単に追加できます。
- **エコシステム**: 多くの拡張機能が公開されています。
