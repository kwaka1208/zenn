---
title: スコアとゲームオーバー判定
---

## スコアの仕組み

2048のスコアは、**タイルが合体するたびに合体後の数字が加算**されます。

- 2 + 2 → 4（4点加算）
- 4 + 4 → 8（8点加算）
- 128 + 128 → 256（256点加算）

スコアの加算は、前の章で実装した `slideRowLeft` 関数がすでに `gained` として返しているので、`App.jsx` で `setScore(prev => prev + result.gained)` と書くだけで動いています。

---

## ゲームオーバーの条件

次の2つの条件が**両方**満たされるとゲームオーバーです。

1. **空きマスがない**（0が1つもない）
2. **隣り合う同じ数字がない**（左右・上下どこを向いても合体できない）

---

## isGameOver 関数を実装する

`src/utils/gameLogic.js` に次の関数を追加します。

```js
export function isGameOver(board) {
  // 空きマスがあればまだ続けられる
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 4; c++) {
      if (board[r][c] === 0) return false;
    }
  }

  // 横方向に隣り合う同じ数字があれば続けられる
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 3; c++) {
      if (board[r][c] === board[r][c + 1]) return false;
    }
  }

  // 縦方向に隣り合う同じ数字があれば続けられる
  for (let r = 0; r < 3; r++) {
    for (let c = 0; c < 4; c++) {
      if (board[r][c] === board[r + 1][c]) return false;
    }
  }

  return true;
}
```

3つの条件をチェックして、どれか1つでも「続けられる理由」があれば `false`（ゲームオーバーでない）を返します。すべての条件をクリアしてはじめて `true`（ゲームオーバー）を返します。

---

## App.jsxにゲームオーバーを組み込む

`src/App.jsx` を更新します。

```jsx
import { useState, useEffect } from 'react';
import './App.css';
import Board from './components/Board';
import {
  createInitialBoard,
  addRandomTile,
  moveLeft,
  moveRight,
  moveUp,
  moveDown,
  isGameOver,
} from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState(0);
  const [gameOver, setGameOver] = useState(false);

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (gameOver) return;

      const moves = {
        ArrowLeft:  moveLeft,
        ArrowRight: moveRight,
        ArrowUp:    moveUp,
        ArrowDown:  moveDown,
      };

      const moveFn = moves[e.key];
      if (!moveFn) return;

      e.preventDefault();
      const result = moveFn(board);
      const newBoard = addRandomTile(result.board);
      setBoard(newBoard);
      setScore(prev => prev + result.gained);

      if (isGameOver(newBoard)) {
        setGameOver(true);
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [board, gameOver]);

  const handleRestart = () => {
    setBoard(createInitialBoard());
    setScore(0);
    setGameOver(false);
  };

  return (
    <div className="game-container">
      <h1>2048</h1>
      <p>スコア：{score}</p>
      <button onClick={handleRestart}>リスタート</button>
      {gameOver && (
        <div className="game-over">
          <p>ゲームオーバー！</p>
        </div>
      )}
      <Board board={board} />
    </div>
  );
}

export default App;
```

### コードの解説

**`if (gameOver) return;`**
ゲームオーバー中はキー入力を無視します。

**`{gameOver && <div>...</div>}`**
`&&` を使うと、条件が `true` のときだけJSXを表示できます。これは「条件付きレンダリング」と呼ばれるReactのよく使うパターンです。

---

## ボードが変わっていない場合は新しいタイルを追加しない

現状のコードには小さな問題があります。キーを押してもタイルが1つも動かなかった場合でも、新しいタイルが追加されてしまいます。

`addRandomTile` を呼ぶ前に、ボードが変わったか確認しましょう。

`src/utils/gameLogic.js` に比較関数を追加します。

```js
export function boardsEqual(a, b) {
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 4; c++) {
      if (a[r][c] !== b[r][c]) return false;
    }
  }
  return true;
}
```

`src/App.jsx` の移動処理を次のように変更します。

```jsx
import { ..., boardsEqual } from './utils/gameLogic';

// useEffect内の処理
const result = moveFn(board);

if (boardsEqual(board, result.board)) return; // 変化なし

const newBoard = addRandomTile(result.board);
setBoard(newBoard);
setScore(prev => prev + result.gained);

if (isGameOver(newBoard)) {
  setGameOver(true);
}
```

---

## まとめ

- スコアは合体時に加算済みなので `App.jsx` では受け取るだけでよい
- ゲームオーバーは「空きマスなし」かつ「合体できる隣接タイルなし」で判定する
- `{条件 && <JSX>}` で条件付きレンダリングができる

次の章では、CSSでゲームの見た目をきれいに整えます。
