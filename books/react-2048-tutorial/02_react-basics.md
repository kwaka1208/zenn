---
title: Reactの基本（コンポーネント・JSX・Props）
---

## Reactとは何か

ReactはFacebook（現Meta）が開発した、UIを作るためのJavaScriptライブラリです。

Reactの大きな特徴は**「コンポーネント」という部品を組み合わせてUIを作る**ことです。レゴブロックのように小さな部品を作り、それを組み合わせて大きな画面を作るイメージです。

---

## コンポーネントとは

コンポーネントとは、**画面の一部を担当するJavaScriptの関数**です。

たとえば、次のコードは「こんにちは！」と表示するコンポーネントです。

```jsx
function Greeting() {
  return <p>こんにちは！</p>;
}
```

関数が返しているのは `<p>こんにちは！</p>` というHTMLのようなコードです。これを**JSX**といいます。

---

## JSXとは

JSXは**JavaScriptの中にHTMLのような記述を書ける構文**です。

```jsx
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

HTMLの `class` はJavaScriptの予約語と重なるため、JSXでは `className` と書きます。また、閉じタグがないタグは `/` で閉じる必要があります。

### JavaScriptの値をJSXに埋め込む

JSXの中で `{}` を使うと、JavaScriptの値を表示できます。

```jsx
function Score() {
  const score = 100;
  return <p>スコア：{score}</p>;
}
```

計算式や関数の呼び出しも書けます。

```jsx
function Score() {
  const score = 100;
  return <p>スコア：{score * 2}</p>;  // スコア：200
}
```

---

## Propsとは

**Props（プロパティ）** は、コンポーネントに外から値を渡す仕組みです。

HTMLの属性のように、コンポーネントにデータを渡すことができます。

```jsx
function Tile({ value }) {
  return <div>{value}</div>;
}
```

このコンポーネントを使う側は次のように書きます。

```jsx
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

`Tile` に `value` という値を渡すと、それぞれのタイルに数字が表示されます。

### Propsのまとめ

- コンポーネントに値を渡す仕組みが Props
- 渡す側は `<Component prop名={値} />` と書く
- 受け取る側は関数の引数 `{ prop名 }` で受け取る

---

## コンポーネントを試してみよう

`src/App.jsx` を次のように書き換えて、コンポーネントを試してみましょう。

```jsx
function Tile({ value }) {
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

- **コンポーネント**：画面の部品となるJavaScript関数
- **JSX**：JavaScriptの中にHTMLのような記述を書ける構文
- **Props**：コンポーネントに外からデータを渡す仕組み

次の章では、画面の「状態」を管理する `useState` を学びます。
