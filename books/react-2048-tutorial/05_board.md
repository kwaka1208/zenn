---
title: ボードコンポーネントの作成
---

## Boardコンポーネントを作る

まず、4×4のグリッドを表示する `Board` コンポーネントを作ります。

`src/components/Board.jsx` を新規作成して、次の内容を書いてください。

```jsx
function Board({ board }) {
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

**`board.map((row, rowIndex) => ...)`**
外側の `map` で行（横1列）を順番に取り出します。

**`row.map((value, colIndex) => ...)`**
内側の `map` で各マスの数字を取り出します。

**`key={`${rowIndex}-${colIndex}`}`**
Reactはリストを描画するとき、各要素に `key` という一意のIDが必要です。ここでは行番号と列番号を組み合わせた文字列を使います。

**`{value !== 0 ? value : ''}`**
値が `0` の場合は何も表示せず、それ以外は数字を表示します。

---

## App.jsxでBoardを使う

`src/App.jsx` を書き換えて、`Board` コンポーネントを使ってみましょう。

```jsx
import Board from './components/Board';

const initialBoard = [
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

---

## スタイルを当てる

現時点ではグリッドのレイアウトが崩れているので、`src/App.css` に最低限のスタイルを追加します。

```css
.board {
  display: grid;
  grid-template-columns: repeat(4, 80px);
  grid-template-rows: repeat(4, 80px);
  gap: 8px;
  background-color: #bbada0;
  padding: 8px;
  border-radius: 6px;
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

`src/App.jsx` に `App.css` のインポートを追加します。

```jsx
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
- `map` を2重にネストして各マスを描画する
- CSSグリッドで4×4のレイアウトを実現する

次の章では、数字ごとに色が変わる `Tile` コンポーネントを作ります。
