---
title: Reactの基本（コンポーネント・JSX・Props）
---

## Reactとは何か

ReactはFacebook（現Meta）が開発した、UIを作るためのJavaScriptライブラリです。

Reactの大きな特徴は**「コンポーネント」という部品を組み合わせてUIを作る**ことです。レゴブロックのように小さな部品を作り、それを組み合わせて大きな画面を作るイメージです。

---

## コンポーネントとは

コンポーネントとは、**画面の一部を担当する関数**です。

たとえば、次のコードは「こんにちは！」と表示するコンポーネントです。

```tsx
function Greeting() {
  return <p>こんにちは！</p>;
}
```

関数が返しているのは `<p>こんにちは！</p>` というHTMLのようなコードです。これを**JSX**といいます。

---

## JSXとは

JSXは**TypeScript（JavaScript）の中にHTMLのような記述を書ける構文**です。

```tsx
function App() {
  return (
    <div>
      <h1>2048</h1>
      <p>ゲームをはじめましょう</p>
    </div>
  );
}
```

JSXはHTMLによく似ていますが、いくつか違いがあります。

| HTML | JSX |
|---|---|
| `class="box"` | `className="box"` |
| `<br>` | `<br />` |
| `<img src="...">` | `<img src="..." />` |

HTMLの `class` はプログラム上の予約語と重なるため、JSXでは `className` と書きます。また、閉じタグがないタグは `/` で閉じる必要があります。

### TypeScriptの値をJSXに埋め込む

JSXの中で `{}` を使うと、TypeScriptの値を表示できます。

```tsx
function Score() {
  const score: number = 100;
  return <p>スコア：{score}</p>;
}
```

`score: number` の `: number` が**型アノテーション**です。「この変数は数値である」とTypeScriptに伝えています。

---

## Propsとは

**Props（プロパティ）** は、コンポーネントに外から値を渡す仕組みです。

TypeScriptでは、Propsの内容を**型（インターフェース）** で定義します。

```tsx
interface TileProps {
  value: number;
}

function Tile({ value }: TileProps) {
  return <div>{value}</div>;
}
```

### インターフェースとは

`interface` は「このオブジェクトにはどんなプロパティがあるか」を定義するTypeScriptの構文です。

```tsx
interface TileProps {
  value: number;  // value という名前の数値
}
```

これにより、`Tile` に渡せるPropsは `value` という数値のみと決まります。数値以外を渡そうとするとエラーになるため、間違いに早く気づけます。

### コンポーネントを使う側

```tsx
function App() {
  return (
    <div>
      <Tile value={2} />
      <Tile value={4} />
      <Tile value={8} />
    </div>
  );
}
```

`Tile` に `value` という数値を渡すと、それぞれのタイルに数字が表示されます。

---

## コンポーネントを試してみよう

`src/App.tsx` を次のように書き換えて、コンポーネントを試してみましょう。

```tsx
interface TileProps {
  value: number;
}

function Tile({ value }: TileProps) {
  return (
    <div style={{ border: '1px solid black', padding: '10px', margin: '5px' }}>
      {value}
    </div>
  );
}

function App() {
  return (
    <div>
      <h1>2048</h1>
      <Tile value={2} />
      <Tile value={4} />
      <Tile value={8} />
    </div>
  );
}

export default App;
```

ブラウザに「2」「4」「8」の箱が表示されれば成功です。

---

## まとめ

- **コンポーネント**：画面の部品となる関数
- **JSX**：TypeScriptの中にHTMLのような記述を書ける構文
- **Props**：コンポーネントに外からデータを渡す仕組み
- **interface**：Propsの形を型で定義するTypeScriptの構文

次の章では、画面の「状態」を管理する `useState` を学びます。
