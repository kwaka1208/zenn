---
title: キャラクターを表示させてみよう
---
次にキャラクター画像を表示させてみます。

## 画像を準備しよう
1. 表示させるキャラクター画像を準備します。今回は[ドッタウン](https://dotown.maeda-design-room.net/)の[青色の忍者](https://dotown.maeda-design-room.net/2681/)の画像を使います。
2. ダウンロードしたファイルの名前を `ninja.png` に変更します。
3. プロジェクトのフォルダの中に `images` フォルダを作成し、その中に `ninja.png` を保存してください。

フォルダ構成は以下のようになります。
```text
プロジェクトフォルダ/
├── game.py
└── images/
    └── ninja.png
```

## プログラムを入力しよう
`game.py` を開き、以下の内容に書き換えます。

```python
import pygame as pg
import sys

# pygame初期化
pg.init()

# 画面設定
screen = pg.display.set_mode((800, 600)) 

# キャラクターの読み込みと設定
player = pg.image.load("images/ninja.png") # 画像を読み込む
player = pg.transform.scale(player, (100, 100)) # サイズを100x100にする
player = pg.transform.flip(player, True, False) # 最初は右向きにする
player_rect = pg.rect.Rect(0, 480, 100, 100) # 表示する位置（左下）

while True:
    # 画面を白で塗りつぶす
    screen.fill(pg.Color("WHITE")) 

    # キャラクターを画面に描画（blit）する
    screen.blit(player, player_rect)

    # 画面を更新
    pg.display.update()

    # イベントをチェック
    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 実行してみよう
実行して、画面の左下に忍者が表示されれば成功です！

## 試してみよう
動いたプログラムの一部を変更すると、それぞれの意味が見えてきます。以下の内容を参考にプログラムを変更し実行してみてください。

1. プログラムの中の数字を変えるとどうなるか見てみよう。
