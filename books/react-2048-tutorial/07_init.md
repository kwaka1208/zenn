---
title: ゲームの初期化
---

## ゲームロジックのファイルを作る

この章では、ゲームの開始に必要な2つの関数を作ります。

- 空のボードを作る関数
- 空きマスにランダムでタイルを追加する関数

`src/utils/gameLogic.ts` を新規作成して、次の内容を書いてください。

```ts
export type Board = number[][];

// 空のボード（4×4、すべて0）を作る
export function createEmptyBoard(): Board {
  return Array.from({ length: 4 }, () => Array(4).fill(0));
}

// 空きマスにランダムで2か4を追加する
export function addRandomTile(board: Board): Board {
  const emptyCells: { r: number; c: number }[] = [];

  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 4; c++) {
      if (board[r][c] === 0) {
        emptyCells.push({ r, c });
      }
    }
  }

  if (emptyCells.length === 0) return board;

  const { r, c } = emptyCells[Math.floor(Math.random() * emptyCells.length)];
  const newValue = Math.random() < 0.9 ? 2 : 4;

  const newBoard = board.map(row => [...row]);
  newBoard[r][c] = newValue;

  return newBoard;
}

// ゲーム開始時のボードを作る（タイルを2つ追加）
export function createInitialBoard(): Board {
  let board = createEmptyBoard();
  board = addRandomTile(board);
  board = addRandomTile(board);
  return board;
}
```

### TypeScriptのポイント

**関数の戻り値の型**
```ts
function createEmptyBoard(): Board { ... }
```
関数名の後ろの `: Board` が**戻り値の型**です。「この関数は `Board` 型の値を返す」という意味です。

**引数の型**
```ts
function addRandomTile(board: Board): Board { ... }
```
引数 `board` に `: Board` をつけることで、「この引数は `Board` 型でなければならない」と指定しています。

**オブジェクトの配列の型**
```ts
const emptyCells: { r: number; c: number }[] = [];
```
`{ r: number; c: number }` は「`r` と `c` という数値を持つオブジェクト」の型です。`[]` をつけると「その配列」になります。

---

### コードの解説

**`Array.from({ length: 4 }, () => Array(4).fill(0))`**
4行を作り、各行に `[0, 0, 0, 0]` という配列を入れます。`fill(0)` はすべての要素を0で埋めるメソッドです。

**ランダムな場所に追加**
`Math.floor(Math.random() * emptyCells.length)` でランダムなインデックスを選び、そのマスに値を追加します。

**`Math.random() < 0.9 ? 2 : 4`**
90%の確率で2、10%の確率で4を追加します。本家2048と同じ確率です。

**`board.map(row => [...row])`**
元のボードを変更しないよう、新しいボードのコピーを作ってから値を変更します。

---

## App.tsxで初期化を使う

`src/App.tsx` を書き換えて、状態とゲームの初期化を組み合わせます。

```tsx
import { useState } from 'react';
import './App.css';
import Board from './components/Board';
import { createInitialBoard } from './utils/gameLogic';

function App() {
  const [board, setBoard] = useState(() => createInitialBoard());
  const [score, setScore] = useState<number>(0);

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

`board` の型は `createInitialBoard()` の戻り値から TypeScript が自動的に `Board` と推測してくれるため、`useState<Board>(...)` と明示しなくても問題ありません。

### useState の初期値に関数を渡す

```tsx
const [board, setBoard] = useState(() => createInitialBoard());
```

`useState` に関数を渡すと、**最初の描画のときだけその関数が実行されます**。`createInitialBoard()` のように計算コストがかかる初期値は、この形で書くのが良い書き方です。

---

## 動作を確認する

ブラウザをリロードするたびにタイルの位置が変わり、「リスタート」ボタンでゲームをリセットできるようになります。

---

## まとめ

- `gameLogic.ts` にゲームロジックをまとめる
- 関数の引数と戻り値に型を指定する（例: `function foo(board: Board): Board`）
- `createEmptyBoard()` で4×4の空ボードを作る
- `addRandomTile()` で空きマスにランダムでタイルを追加する

次の章では、キーボードの入力を受け取って方向を判定する処理を実装します。
