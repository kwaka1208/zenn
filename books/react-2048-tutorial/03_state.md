---
title: 状態管理とuseState
---

## 「状態」とは何か

Reactにおける**状態（State）** とは、**時間とともに変わるデータ**のことです。

2048ゲームを例にすると、次のようなものが状態です。

- ボードの各マスに入っている数字
- 現在のスコア
- ゲームオーバーかどうか

状態が変わると、Reactは自動的に画面を更新します。これがReactの大きな強みです。

---

## useStateの使い方

Reactで状態を管理するには `useState` という機能（フック）を使います。

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>カウント：{count}</p>
      <button onClick={() => setCount(count + 1)}>増やす</button>
    </div>
  );
}
```

### useStateの書き方

```jsx
const [状態の変数, 更新関数] = useState(初期値);
```

| 部分 | 説明 |
|---|---|
| `状態の変数` | 現在の値を参照するための変数 |
| `更新関数` | 状態を変えるための関数（呼ぶと画面が再描画される） |
| `初期値` | 最初の値 |

`setCount(新しい値)` を呼ぶと、`count` が更新されて画面が自動的に再描画されます。

---

## 試してみよう：カウンターを作る

`src/App.jsx` を次のように書き換えてみてください。

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>カウント：{count}</p>
      <button onClick={() => setCount(count + 1)}>増やす</button>
      <button onClick={() => setCount(0)}>リセット</button>
    </div>
  );
}

function App() {
  return (
    <div>
      <h1>カウンター</h1>
      <Counter />
    </div>
  );
}

export default App;
```

「増やす」ボタンを押すたびに数字が増え、「リセット」ボタンで0に戻ります。

**ポイント：** ボタンを押しても `count` という変数を直接変えているわけではありません。`setCount()` を呼ぶことでReactに「状態を変えてほしい」と伝え、Reactが画面を再描画します。

:::message
状態を変えるときは必ず `setCount()` のような更新関数を使ってください。
`count = count + 1` のように直接変更しても、画面は更新されません。
:::

---

## 配列を状態にする

2048では、ボードの数字の並びを配列として状態に持ちます。配列を使った例を見てみましょう。

```jsx
import { useState } from 'react';

function App() {
  const [tiles, setTiles] = useState([2, 4, 8, 16]);

  const addTile = () => {
    setTiles([...tiles, 32]);
  };

  return (
    <div>
      <p>{tiles.join(', ')}</p>
      <button onClick={addTile}>タイルを追加</button>
    </div>
  );
}

export default App;
```

配列を更新するときは `[...tiles, 新しい値]` のように**新しい配列を作って渡す**ことがポイントです。

:::message
配列を状態にする場合、`tiles.push(32)` のような**元の配列を変更する操作はNG**です。必ず新しい配列を作って `setTiles()` に渡してください。
:::

---

## まとめ

- **状態（State）** は時間とともに変わるデータ
- `useState(初期値)` で状態を定義する
- 状態を変えるときは必ず更新関数（`setXxx`）を使う
- 状態が変わると、Reactが自動で画面を再描画する

次の章では、2048のゲーム全体の設計を考えます。
