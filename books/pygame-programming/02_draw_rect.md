---
title: 画面に四角を描いてみよう
---
まず初めに画面に四角を描いてみましょう。

## プログラムを入力しよう
1. Visual Studio Codeで新しいファイル `game.py` を作成します。
1. 以下のコードを入力しましょう。

```python
import pygame as pg
import sys

# pygame初期化
pg.init()

# 画面設定（横800、縦600ピクセル）
screen = pg.display.set_mode((800, 600)) 

while True:
    # 画面を白で塗りつぶす
    screen.fill(pg.Color("WHITE")) 

    # 赤い四角形を描画（画面、色、位置とサイズ）
    pg.draw.rect(screen, pg.Color("RED"), pg.Rect(10, 20, 100, 150))

    # 画面を更新
    pg.display.update()

    # イベントをチェック
    for event in pg.event.get():
        # 閉じるボタンが押されたら終了
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

入力したら保存します。保存や実行の方法がわからない場合は、前の章「[開発の準備と実行方法](01_execution)」を確認してください。

## 実行してみよう
プログラムが正しく入力できていれば、白い画面に赤い四角が表示されます。

## 試してみよう
動いたプログラムの一部を変更すると、それぞれの意味が見えてきます。以下の内容を参考にプログラムを変更し実行してみてください。

1. プログラムの中の数字を変えるとどうなるか見てみよう。
1. プログラムの色の名前（WHITEやREDなど）を他の色に変えてみよう。
