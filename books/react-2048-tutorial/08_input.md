---
title: キーボード入力の処理（useEffect）
---

## useEffectとは

`useEffect` は、コンポーネントが画面に表示されたあとに**副作用（Side Effect）** を実行するための機能（フック）です。

**副作用** とは、コンポーネントの描画以外に行う処理のことです。

- キーボードイベントの登録
- データの取得（API通信）
- タイマーの設定

2048では、キーボードの矢印キーを押したときにゲームを動かすために `useEffect` を使います。

---

## useEffectの基本的な書き方

```jsx
import { useEffect } from 'react';

useEffect(() => {
  // ここに副作用の処理を書く

  return () => {
    // クリーンアップ（後片付け）の処理
  };
}, [依存配列]);
```

| 部分 | 説明 |
|---|---|
| 1つ目の引数 | 実行したい処理を書いた関数 |
| `return () => {}` | コンポーネントが消えるときに実行される後片付け |
| 依存配列 | ここに書いた値が変わるたびに処理が再実行される |

依存配列を `[]`（空の配列）にすると、**コンポーネントが最初に表示されたときだけ**実行されます。

---

## キーボードイベントを登録する

`src/App.jsx` を次のように更新します。

```jsx
import { useState, useEffect } from 'react';
import './App.css';
import Board from './components/Board';
import { createInitialBoard } from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState(0);

  useEffect(() => {
    const handleKeyDown = (e) => {
      switch (e.key) {
        case 'ArrowLeft':
          console.log('左');
          break;
        case 'ArrowRight':
          console.log('右');
          break;
        case 'ArrowUp':
          console.log('上');
          break;
        case 'ArrowDown':
          console.log('下');
          break;
      }
    };

    window.addEventListener('keydown', handleKeyDown);

    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, []);

  const handleRestart = () => {
    setBoard(createInitialBoard());
    setScore(0);
  };

  return (
    <div className="game-container">
      <h1>2048</h1>
      <p>スコア：{score}</p>
      <button onClick={handleRestart}>リスタート</button>
      <Board board={board} />
    </div>
  );
}

export default App;
```

### コードの解説

**`window.addEventListener('keydown', handleKeyDown)`**
ブラウザウィンドウ全体でキーボードの入力を受け取ります。

**`e.key`**
押されたキーの名前が入っています。矢印キーは `'ArrowLeft'`・`'ArrowRight'`・`'ArrowUp'`・`'ArrowDown'` です。

**クリーンアップ**
```jsx
return () => {
  window.removeEventListener('keydown', handleKeyDown);
};
```
コンポーネントが消えるとき（ページ移動など）に、登録したイベントを削除します。これを忘れると、不要なイベントが残り続けてメモリリークの原因になります。

---

## 動作を確認する

ブラウザの開発者ツール（F12キー）でコンソールを開き、矢印キーを押してみてください。「左」「右」「上」「下」と表示されれば成功です。

:::message
矢印キーを押したときにページがスクロールしてしまう場合は、`handleKeyDown` の中に `e.preventDefault()` を追加してください。

```jsx
const handleKeyDown = (e) => {
  if (['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(e.key)) {
    e.preventDefault();
  }
  // ...
};
```
:::

---

## まとめ

- `useEffect` はコンポーネントの描画後に副作用を実行する
- キーボードイベントは `window.addEventListener` で登録する
- `useEffect` のクリーンアップでイベントを解除することを忘れずに

次の章では、左右のキーが押されたときにタイルを移動・合体させるロジックを実装します。
