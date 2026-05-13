---
title: "TypeScriptで安全なコードを書こう"
---
JavaScriptは柔軟ですが、規模が大きくなると「型」がないためにエラーが発生しやすくなります。そこで役立つのが **TypeScript** です。

## TypeScriptとは？
JavaScriptに「型」を追加した言語です。プログラムを実行する前に間違いを見つけられるため、安全で読みやすいコードが書けます。

## 環境構築
TypeScriptをNode.jsで動かすための準備をします。

```bash
# TypeScript本体と、実行ツールのインストール
npm install --save-dev typescript ts-node @types/node @types/express
# 設定ファイルの作成
npx tsc --init
```

## TypeScriptで書いてみる
`server.ts` を作成します。

```typescript:server.ts
import express, { Request, Response } from 'express';
const app = express();
const PORT: number = 3000;

app.get('/', (req: Request, res: Response) => {
  res.send('TypeScriptで型安全なサーバーが動いています！');
});

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}/`);
});
```

## 実行方法
`ts-node` を使うと、コンパイルなしで直接実行できます。

```bash
npx ts-node server.ts
```

型を定義することで、エディタの補完が強力になり、開発効率が劇的に向上します。
