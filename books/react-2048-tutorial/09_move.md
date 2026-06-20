---
title: タイルの移動ロジック（左右）
---

## 移動ロジックの考え方

2048のタイル移動は、次の2つの処理を組み合わせたものです。

1. **ゼロ（空きマス）を取り除いて左（右）に詰める**
2. **隣り合う同じ数字を合体させる**

まずは「1行分の移動」を考えます。行が動けば、4行すべてに適用するだけです。

---

## 1行を左に移動する

`[0, 2, 0, 2]` という行を左に移動すると `[4, 0, 0, 0]` になります。手順を分解してみましょう。

**Step 1: 0を取り除いて詰める**
```
[0, 2, 0, 2]  →  [2, 2]
```

**Step 2: 左から順に同じ数字を合体する**
```
[2, 2]  →  [4]
```

**Step 3: 右側を0で埋めて長さを4に戻す**
```
[4]  →  [4, 0, 0, 0]
```

---

## slideRowLeft 関数を実装する

`src/utils/gameLogic.js` に次の関数を追加します。

```js
// 1行を左にスライドして合体させる（スコア加算分を返す）
function slideRowLeft(row) {
  // Step 1: 0を取り除く
  const tiles = row.filter(v => v !== 0);

  let gained = 0;

  // Step 2: 左から合体
  for (let i = 0; i < tiles.length - 1; i++) {
    if (tiles[i] === tiles[i + 1]) {
      tiles[i] *= 2;
      gained += tiles[i];
      tiles.splice(i + 1, 1);
    }
  }

  // Step 3: 右側を0で埋める
  while (tiles.length < 4) {
    tiles.push(0);
  }

  return { row: tiles, gained };
}
```

### コードの解説

**`row.filter(v => v !== 0)`**
`filter` は条件を満たす要素だけを残した新しい配列を返します。ここでは0以外（= 数字があるタイル）を残します。

**合体ループ**
```js
if (tiles[i] === tiles[i + 1]) {
  tiles[i] *= 2;      // 合体して2倍にする
  gained += tiles[i]; // スコアに加算
  tiles.splice(i + 1, 1); // 右のタイルを削除
}
```
`splice(index, 削除数)` は指定した位置から要素を取り除くメソッドです。

---

## moveLeft / moveRight を実装する

`src/utils/gameLogic.js` に左右移動の関数を追加します。

```js
export function moveLeft(board) {
  let totalGained = 0;
  const newBoard = board.map(row => {
    const { row: newRow, gained } = slideRowLeft(row);
    totalGained += gained;
    return newRow;
  });
  return { board: newBoard, gained: totalGained };
}

export function moveRight(board) {
  let totalGained = 0;
  const newBoard = board.map(row => {
    const reversed = [...row].reverse();
    const { row: slid, gained } = slideRowLeft(reversed);
    totalGained += gained;
    return slid.reverse();
  });
  return { board: newBoard, gained: totalGained };
}
```

**右移動のコツ**
右移動は「行を逆順にして左移動し、結果を再び逆順にする」だけで実現できます。

```
元: [2, 0, 0, 2]
逆: [2, 0, 0, 2]  → 左移動 → [4, 0, 0, 0]
再逆: [0, 0, 0, 4]  ← これが右移動の結果
```

---

## App.jsxに移動処理をつなぐ

`src/App.jsx` の `useEffect` を更新して、左右キーで実際に移動するようにします。

```jsx
import { useState, useEffect } from 'react';
import './App.css';
import Board from './components/Board';
import { createInitialBoard, addRandomTile, moveLeft, moveRight } from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState(0);

  useEffect(() => {
    const handleKeyDown = (e) => {
      let result = null;

      if (e.key === 'ArrowLeft')  result = moveLeft(board);
      if (e.key === 'ArrowRight') result = moveRight(board);

      if (!result) return;

      e.preventDefault();
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

:::message
`useEffect` の依存配列を `[board]` にしています。`board` が変わるたびに最新のボード情報でイベントを登録し直すことで、古いボードの状態を参照してしまうバグを防ぎます。
:::

---

## 動作確認

矢印キーの左右を押すと、タイルが移動・合体するようになります。移動のたびに新しいタイルが出現することも確認してください。

---

## まとめ

- 1行の移動は「0除去 → 合体 → 0埋め」の3ステップ
- 右移動は「逆順にして左移動して再び逆順」で実装できる
- `useEffect` の依存配列に `board` を入れて最新の状態を参照する

次の章では、同じ考え方を使って上下の移動を実装します。
