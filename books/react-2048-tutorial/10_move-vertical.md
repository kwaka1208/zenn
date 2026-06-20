---
title: タイルの移動ロジック（上下）
---

## 上下移動の考え方

上下の移動は行（横）ではなく列（縦）を動かします。

しかし、前の章で作った `slideRowLeft` は「行を左に動かす」関数です。これを列にも使いまわすために、**転置（transpose）** というテクニックを使います。

---

## 転置（transpose）とは

転置とは、**行と列を入れ替える操作**です。

```
元のボード（4×4）:
[1, 2, 3, 4]
[5, 6, 7, 8]
[9, 0, 1, 2]
[3, 4, 5, 6]

転置後:
[1, 5, 9, 3]
[2, 6, 0, 4]
[3, 7, 1, 5]
[4, 8, 2, 6]
```

転置すると「列を行として扱える」ようになります。

- 上に移動したい → 転置 → 左移動 → 転置して戻す
- 下に移動したい → 転置 → 右移動 → 転置して戻す

---

## transpose 関数を実装する

`src/utils/gameLogic.js` に転置関数を追加します。

```js
function transpose(board) {
  return board[0].map((_, colIndex) => board.map(row => row[colIndex]));
}
```

### コードの解説

`board[0].map((_, colIndex) => ...)`
まず「列番号の一覧（0, 1, 2, 3）」を作ります。`_` は使わない引数を表す慣習的な書き方です。

`board.map(row => row[colIndex])`
各行から `colIndex` 番目の値を取り出して、新しい行（= 元の列）を作ります。

---

## moveUp / moveDown を実装する

同じファイルに上下移動の関数を追加します。

```js
export function moveUp(board) {
  const transposed = transpose(board);
  const { board: moved, gained } = moveLeft(transposed);
  return { board: transpose(moved), gained };
}

export function moveDown(board) {
  const transposed = transpose(board);
  const { board: moved, gained } = moveRight(transposed);
  return { board: transpose(moved), gained };
}
```

`moveUp` と `moveDown` はそれぞれ転置 → 左右移動 → 再転置の3行で書けます。

---

## App.jsxに上下移動をつなぐ

`src/App.jsx` を更新して、4方向の移動をすべて対応させます。

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
} from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState(0);

  useEffect(() => {
    const handleKeyDown = (e) => {
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
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [board]);

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

`moves` オブジェクトにキー名と関数を対応させることで、`if` 文を並べずにすっきり書けます。

---

## 動作確認

4方向の矢印キーすべてでタイルが動くようになります。

- 左右: タイルが左右に寄って合体する
- 上下: タイルが上下に寄って合体する
- 動くたびに新しいタイル（2か4）が出現する

---

## まとめ

- 上下移動は「転置して左右移動して再転置」で実装できる
- `transpose` 関数で行と列を入れ替える
- キーと関数をオブジェクトで対応させると `if` 文が不要になる

次の章では、スコアとゲームオーバー判定を実装します。
