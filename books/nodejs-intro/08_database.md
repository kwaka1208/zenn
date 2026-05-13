---
title: "データを保存しよう（データベース連携）"
---

アプリを再起動してもデータが消えないようにするには、**データベース (DB)** が必要です。

## SQLite3を使ってみる
初心者にとって扱いやすい、設定不要なファイルベースのデータベース「SQLite3」を例に解説します。

## インストール
```bash
npm install sqlite3
```

## データの保存と取得
`database.js` を作成して、データベースを操作してみましょう。

```javascript:database.js
const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database(':memory:'); // 今回はメモリ上に作成

db.serialize(() => {
  // テーブル作成
  db.run("CREATE TABLE users (name TEXT)");

  // データ挿入
  const stmt = db.prepare("INSERT INTO users VALUES (?)");
  stmt.run("Node太郎");
  stmt.finalize();

  // データ取得
  db.each("SELECT name FROM users", (err, row) => {
    console.log(`ユーザー名: ${row.name}`);
  });
});

db.close();
```

## 実践的な構成
実際には、**Prisma** や **TypeORM** といった「ORM」と呼ばれるツールを使うと、SQLを直接書かずにTypeScriptから安全にDBを操作できるようになります。

データの永続化ができるようになると、ユーザー登録やブログ投稿など、作れるアプリの幅が一気に広がります。
