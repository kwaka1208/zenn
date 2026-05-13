---
title: "自分だけのWebサーバーを作ろう"
---
Node.jsの真骨頂である、Webサーバーの作成に挑戦しましょう。

## 標準モジュール http を使う
Node.jsには標準で `http` というサーバー機能が備わっています。

```javascript:server.js
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
  res.end('こんにちは！Node.jsサーバーです。');
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}/`);
});
```

## サーバーの起動
```bash
node server.js
```

ブラウザで `http://localhost:3000/` にアクセスしてみてください。メッセージが表示されるはずです。

## サーバーを止める
ターミナルで `Ctrl + C` を押すと終了します。
