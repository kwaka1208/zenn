---
title: CSSでスタイリング
---

## 全体のスタイルを整える

この章では、ゲームの見た目を本家2048に近いデザインに整えます。

`src/App.css` の内容をすべて書き換えてください。

```css
/* ページ全体 */
body {
  margin: 0;
  background-color: #faf8ef;
  font-family: 'Arial', sans-serif;
  display: flex;
  justify-content: center;
  padding: 20px;
}

/* ゲーム全体のコンテナ */
.game-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

/* タイトル */
h1 {
  font-size: 64px;
  font-weight: bold;
  color: #776e65;
  margin: 0;
}

/* スコア表示 */
.score-box {
  background-color: #bbada0;
  color: #f9f6f2;
  border-radius: 6px;
  padding: 8px 20px;
  font-size: 18px;
  font-weight: bold;
}

.score-label {
  font-size: 12px;
  text-transform: uppercase;
  opacity: 0.7;
}

/* リスタートボタン */
button {
  background-color: #8f7a66;
  color: #f9f6f2;
  border: none;
  border-radius: 4px;
  padding: 10px 20px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
}

button:hover {
  background-color: #7a6657;
}

/* ゲームボード */
.board {
  display: grid;
  grid-template-columns: repeat(4, 100px);
  grid-template-rows: repeat(4, 100px);
  gap: 12px;
  background-color: #bbada0;
  padding: 12px;
  border-radius: 8px;
}

/* 各マス（空きマス） */
.cell {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(238, 228, 218, 0.35);
  border-radius: 4px;
  font-size: 28px;
  font-weight: bold;
}

/* 数字のあるタイル */
.tile {
  transition: background-color 0.1s ease;
}

/* ゲームオーバー表示 */
.game-over {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(238, 228, 218, 0.73);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
}

.game-over p {
  font-size: 48px;
  font-weight: bold;
  color: #776e65;
  margin: 0;
}

/* ボード周辺のラッパー（ゲームオーバーのoverlay用） */
.board-wrapper {
  position: relative;
}
```

---

## スコア表示をきれいにする

`src/App.jsx` のスコア表示部分を書き換えます。

```jsx
<div className="score-box">
  <div className="score-label">スコア</div>
  <div>{score}</div>
</div>
```

---

## ゲームオーバーのオーバーレイを修正する

ゲームオーバー表示をボードの上に重ねるため、`src/App.jsx` のボード周辺を `board-wrapper` で囲みます。

```jsx
return (
  <div className="game-container">
    <h1>2048</h1>
    <div className="score-box">
      <div className="score-label">スコア</div>
      <div>{score}</div>
    </div>
    <button onClick={handleRestart}>リスタート</button>
    <div className="board-wrapper">
      {gameOver && (
        <div className="game-over">
          <p>ゲームオーバー！</p>
        </div>
      )}
      <Board board={board} />
    </div>
  </div>
);
```

---

## タイルのフォントサイズを調整する

数字が4桁（1024・2048）になるとタイルからはみ出すことがあります。`Tile.jsx` でフォントサイズを動的に変えましょう。

`src/components/Tile.jsx` の `Tile` 関数を更新します。

```jsx
function Tile({ value }) {
  if (value === 0) return <div className="cell" />;

  const style = TILE_COLORS[value] ?? DEFAULT_TILE_STYLE;
  const fontSize = value >= 1024 ? '20px' : value >= 128 ? '24px' : '28px';

  return (
    <div
      className="cell tile"
      style={{
        backgroundColor: style.background,
        color: style.color,
        fontSize,
      }}
    >
      {value}
    </div>
  );
}
```

---

## 完成した見た目を確認する

ここまでの変更を保存してブラウザを確認してください。本家2048に近い見た目になっているはずです。

- タイトル「2048」が大きく表示される
- スコアがボックスで表示される
- タイルの色が数字に応じて変わる
- ゲームオーバー時にオーバーレイが表示される

---

## まとめ

- `display: grid` と `gap` でボードのレイアウトを整える
- `position: relative` / `absolute` でオーバーレイを重ねる
- 数字の桁数に応じてフォントサイズを変えると見た目がきれいになる

次の最終章では、チュートリアル全体を振り返り、次のステップを紹介します。
