---
title: ボードコンポーネントの作成
---

## Boardコンポーネントを作る

まず、4×4のグリッドを表示する `Board` コンポーネントを作ります。

`src/components/Board.tsx` を新規作成して、次の内容を書いてください。

```tsx
type Board = number[][];

interface BoardProps {
  board: Board;
}

function Board({ board }: BoardProps) {
  return (
    <div className="board">
      {board.map((row, rowIndex) =>
        row.map((value, colIndex) => (
          <div key={`${rowIndex}-${colIndex}`} className="cell">
            {value !== 0 ? value : ''}
          </div>
        ))
      )}
    </div>
  );
}

export default Board;
```

### コードの解説

**`type Board = number[][]`**
4章で設計した型エイリアスをここでも定義します。後の章でこの型定義を共通ファイルに移動しますが、今は各ファイルに書いておきます。

**`interface BoardProps`**
`Board` コンポーネントが受け取るPropsの型定義です。`board` という `Board` 型のプロパティを1つ持ちます。

**`board.map((row, rowIndex) => ...)`**
外側の `map` で行（横1列）を順番に取り出します。

**`row.map((value, colIndex) => ...)`**
内側の `map` で各マスの数字を取り出します。

**`key={`${rowIndex}-${colIndex}`}`**
Reactはリストを描画するとき、各要素に `key` という一意のIDが必要です。ここでは行番号と列番号を組み合わせた文字列を使います。

**`{value !== 0 ? value : ''}`**
値が `0` の場合は何も表示せず、それ以外は数字を表示します。

---

## App.tsxでBoardを使う

`src/App.tsx` の内容をすべて次のように書き換えてください。

```tsx
import Board from './components/Board';

type Board = number[][];

const initialBoard: Board = [
  [0, 0, 2, 0],
  [0, 4, 0, 0],
  [0, 0, 0, 8],
  [2, 0, 0, 0],
];

function App() {
  return (
    <div>
      <h1>2048</h1>
      <Board board={initialBoard} />
    </div>
  );
}

export default App;
```

`const initialBoard: Board` のように変数にも型を指定できます。配列の中身が `Board` 型（= `number[][]`）と合っていないとTypeScriptがエラーを出してくれます。

---

## スタイルを当てる

現時点ではグリッドのレイアウトが崩れているので、`src/App.css` に次のスタイルを追加してください（現在は空のファイルです）。

```css
.board {
  display: grid;
  grid-template-columns: repeat(4, 80px);
  grid-template-rows: repeat(4, 80px);
  gap: 8px;
  background-color: #bbada0;
  padding: 8px;
  border-radius: 6px;
  width: fit-content;
}

.cell {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cdc1b4;
  border-radius: 4px;
  font-size: 24px;
  font-weight: bold;
}
```

`src/App.tsx` の先頭2行を次のように変更してください（`import Board` の行はすでにあるので、`import './App.css'` を1行目に追加します）。

```tsx
import './App.css';
import Board from './components/Board';
```

ブラウザを確認すると、4×4のグリッドに数字が表示されているはずです。

---

## CSSグリッドについて

`display: grid` と `grid-template-columns: repeat(4, 80px)` を使うと、自動的に4列のグリッドレイアウトが作れます。

```css
grid-template-columns: repeat(4, 80px);
/* ↑ 80px幅の列を4つ作る */
```

16個の `<div>` を並べると、Reactが自動で4行4列に配置してくれます。

---

## まとめ

- `Board` コンポーネントは `board`（二次元配列）をPropsで受け取る
- `interface BoardProps` でPropsの型を定義する
- `map` を2重にネストして各マスを描画する
- CSSグリッドで4×4のレイアウトを実現する

次の章では、数字ごとに色が変わる `Tile` コンポーネントを作ります。
