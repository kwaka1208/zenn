---
title: タイルコンポーネントの作成
---

## Tileコンポーネントを作る

2048では、数字が大きくなるほどタイルの色が変わります。この章では、数字に応じて色が変わる `Tile` コンポーネントを作ります。

`src/components/Tile.tsx` を新規作成して、次の内容を書いてください。

```tsx
interface TileStyle {
  background: string;
  color: string;
}

const TILE_COLORS: Record<number, TileStyle> = {
  2:    { background: '#eee4da', color: '#776e65' },
  4:    { background: '#ede0c8', color: '#776e65' },
  8:    { background: '#f2b179', color: '#f9f6f2' },
  16:   { background: '#f59563', color: '#f9f6f2' },
  32:   { background: '#f67c5f', color: '#f9f6f2' },
  64:   { background: '#f65e3b', color: '#f9f6f2' },
  128:  { background: '#edcf72', color: '#f9f6f2' },
  256:  { background: '#edcc61', color: '#f9f6f2' },
  512:  { background: '#edc850', color: '#f9f6f2' },
  1024: { background: '#edc53f', color: '#f9f6f2' },
  2048: { background: '#edc22e', color: '#f9f6f2' },
};

const DEFAULT_TILE_STYLE: TileStyle = { background: '#3c3a32', color: '#f9f6f2' };

interface TileProps {
  value: number;
}

function Tile({ value }: TileProps) {
  if (value === 0) return <div className="cell" />;

  const style = TILE_COLORS[value] ?? DEFAULT_TILE_STYLE;

  return (
    <div
      className="cell tile"
      style={{ backgroundColor: style.background, color: style.color }}
    >
      {value}
    </div>
  );
}

export default Tile;
```

### コードの解説

**`interface TileStyle`**
背景色と文字色を持つオブジェクトの型定義です。`string` は文字列の型です。

**`Record<number, TileStyle>`**
`Record<キーの型, 値の型>` はオブジェクトの型を表すTypeScriptの書き方です。ここでは「キーが数値、値が `TileStyle`」のオブジェクトを意味します。

**`TILE_COLORS[value] ?? DEFAULT_TILE_STYLE`**
`??` は**Nullish合体演算子**といい、左辺が `null` または `undefined` のときだけ右辺を返します。2048を超えた数字には `DEFAULT_TILE_STYLE` が適用されます。

---

## BoardにTileを組み込む

`src/components/Board.tsx` の内容をすべて次のように書き換えてください。

```tsx
import Tile from './Tile';

type Board = number[][];

interface BoardProps {
  board: Board;
}

function Board({ board }: BoardProps) {
  return (
    <div className="board">
      {board.map((row, rowIndex) =>
        row.map((value, colIndex) => (
          <Tile
            key={`${rowIndex}-${colIndex}`}
            value={value}
          />
        ))
      )}
    </div>
  );
}

export default Board;
```

---

## スタイルを更新する

`src/App.css` に `.tile` のスタイルを追加します。

```css
.tile {
  transition: background-color 0.1s ease;
}
```

`transition` を使うと、色が変わるときに少しなめらかなアニメーションがかかります。

---

## 動作を確認する

`src/App.tsx` の `initialBoard` の値だけを次のように書き換えて、さまざまな数字のタイルが色付きで表示されるか確認しましょう。

```tsx
const initialBoard: Board = [
  [2,   4,   8,   16],
  [32,  64,  128, 256],
  [512, 1024, 2048, 0],
  [0,   0,   0,   0],
];
```

小さい数字は薄いベージュ、大きくなるにつれてオレンジ・赤・黄色と変化します。

---

## まとめ

- `interface TileStyle` で色情報の型を定義する
- `Record<number, TileStyle>` でキーが数値のオブジェクトの型を書く
- `??` 演算子でマッピングにない数字のデフォルト色を設定する

次の章では、ゲームの初期化ロジックを実装します。空のボードを作り、ランダムな位置にタイルを配置する関数を書きます。
