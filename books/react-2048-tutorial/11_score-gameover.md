---
title: スコアとゲームオーバー判定
---

## スコアの仕組み

2048のスコアは、**タイルが合体するたびに合体後の数字が加算**されます。

- 2 + 2 → 4（4点加算）
- 4 + 4 → 8（8点加算）
- 128 + 128 → 256（256点加算）

スコアの加算は、前の章で実装した `slideRowLeft` 関数がすでに `gained` として返しているので、`App.tsx` で `setScore(prev => prev + result.gained)` と書くだけで動いています。

---

## ゲームオーバーの条件

次の2つの条件が**両方**満たされるとゲームオーバーです。

1. **空きマスがない**（0が1つもない）
2. **隣り合う同じ数字がない**（左右・上下どこを向いても合体できない）

---

## isGameOver 関数を実装する

`src/utils/gameLogic.ts` に次の関数を追加します。

```ts
export function isGameOver(board: Board): boolean {
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

戻り値の型は `: boolean` です。3つの条件をチェックして、どれか1つでも「続けられる理由」があれば `false` を返し、すべての条件をクリアしてはじめて `true` を返します。

---

## boardsEqual 関数を追加する

キーを押してもタイルが1つも動かなかった場合、新しいタイルを追加しないようにします。ボードが変わったか比較する関数を追加します。

```ts
export function boardsEqual(a: Board, b: Board): boolean {
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 4; c++) {
      if (a[r][c] !== b[r][c]) return false;
    }
  }
  return true;
}
```

引数 `a` と `b` はどちらも `Board` 型で、戻り値は `boolean` です。

---

## App.tsxにゲームオーバーを組み込む

`src/App.tsx` の内容をすべて次のように書き換えてください。

```tsx
import { useState, useEffect } from 'react';
import './App.css';
import Board from './components/Board';
import {
  type Board as BoardType,
  type MoveResult,
  createInitialBoard,
  addRandomTile,
  moveLeft,
  moveRight,
  moveUp,
  moveDown,
  isGameOver,
  boardsEqual,
} from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState<number>(0);
  const [gameOver, setGameOver] = useState<boolean>(false);

  useEffect(() => {
    const moves: Record<string, (board: BoardType) => MoveResult> = {
      ArrowLeft:  moveLeft,
      ArrowRight: moveRight,
      ArrowUp:    moveUp,
      ArrowDown:  moveDown,
    };

    const handleKeyDown = (e: KeyboardEvent) => {
      if (gameOver) return;

      const moveFn = moves[e.key];
      if (!moveFn) return;

      e.preventDefault();
      const result = moveFn(board);

      if (boardsEqual(board, result.board)) return;

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
ゲームオーバー中はキー入力を無視します。`gameOver` は `boolean` 型なので、`if (gameOver)` がそのまま使えます。

**`{gameOver && <div>...</div>}`**
`&&` を使うと、条件が `true` のときだけTSXを表示できます。これは「条件付きレンダリング」と呼ばれるReactでよく使うパターンです。

**依存配列 `[board, gameOver]`**
`gameOver` を依存配列に追加しています。`handleKeyDown` の中で `gameOver` を参照しているため、最新の値を参照するために必要です。

---

## まとめ

- `isGameOver(board): boolean` でゲームオーバーを判定する
- `boardsEqual(a, b): boolean` でボードの変化を確認する
- 関数の戻り値に `: boolean` をつけると意図が明確になる
- `{条件 && <TSX>}` で条件付きレンダリングができる

次の章では、CSSでゲームの見た目をきれいに整えます。
