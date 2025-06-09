---
title: 画面に四角を描いてみよう
---
まず初めに画面に四角を描いてみましょう。

## プログラムを入力しよう
1. Visual Studio Codeで新しいファイル"game.py"を作成します。
1. 以下のコードを"game.py"に入力していきましょう。[こちらをクリックすると別ウインドウで表示できます](https://github.com/kwaka1208/resources/blob/main/pygame/game01.py)）。
1. 入力したら保存します。保存の操作は、ChromebookとWindowsの方は"Ctrl" + "S"、Macの方は"Command" + "S"です。プログラムの保存は最後にまとめてやるのではなく、ある程度入力したら保存するの方が良いです。もし入力途中でトラブルが起こったらせっかく入力したプログラムが消えてしまう可能性があります。

```python
import pygame as pg
import sys

# pygame初期化
pg.init()

# 画面設定
screen = pg.display.set_mode((800, 600)) 

while True:
    # 画面を白で塗りつぶす
    screen.fill(pg.Color("WHITE")) 

    # 赤い四角形を描画
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

## 実行してみよう
プログラムの入力ができたら、プログラムを実行してます。以下の手順を参考にしてください。

### Chromebookの方
1. ターミナルを起動します。
1. cd pygameと入力してEnterキーを押します。
1. python3 game.pyと入力してEnterキーを押します。

### Windowsの方
1. コマンドプロンプトを起動します。
1. cd Documentsと入力してEnterキーを押します。
1. cd pygameと入力してEnterキーを押します。
1. python game.pyと入力してEnterキーを押します。

### Macの方
1. ターミナルを起動します。
1. cd Documentsと入力してEnterキーを押します。
1. cd pygameと入力してEnterキーを押します。
1. python3 game.pyと入力してEnterキーを押します。

## 試してみよう
動いたプログラムの一部を変更すると、それぞれの意味が見えてきます。以下の内容を参考にプログラムを変更し実行してみてください。

1. プログラムの中の数字を変えるとどうなるか見てみよう。
1. プログラムの色の名前（WHITEやREDなど）を他の色に変えてみよう。
