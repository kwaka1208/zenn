---
title: キャラクターを動かしてみよう
---
次にキャラクターをキー操作で動かしてみましょう。

## 動かし方を決めよう
キャラクターの動かし方、ここでは左右方向のみの動きにします。

- カーソルキーの左を押したら左に動く
- カーソルキーの右を押したら右に動く

## プログラムを入力しよう
`game.py` に移動の処理を追加します。

### 変更点（diff）
```diff
     # 画面を白で塗りつぶす
     screen.fill(pg.Color("WHITE")) 
 
+    # キー入力の情報を取得
+    key = pg.key.get_pressed()
+    if(key[pg.K_RIGHT]):
+        # 右向きキーが押された時、X座標を10増やす
+        player_rect.x += 10
+    if(key[pg.K_LEFT]):
+        # 左向きキーが押された時、X座標を10減らす
+        player_rect.x -= 10
+
     # キャラクターを画面に描画（blit）する
     screen.blit(player, player_rect)
 
     # 画面を更新
     pg.display.update()
 
+    # ゲームの動作速度を固定する（秒間60フレーム）
+    pg.time.Clock().tick(60)
+
     # イベントをチェック
```

### 全体のコード
```python
import pygame as pg
import sys

# pygame初期化
pg.init()

# 画面設定
screen = pg.display.set_mode((800, 600)) 

# キャラクターの読み込みと設定
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (100, 100))
player = pg.transform.flip(player, True, False)
player_rect = pg.rect.Rect(0, 480, 100, 100)

while True:
    # 画面を白で塗りつぶす
    screen.fill(pg.Color("WHITE")) 

    # キー入力の情報を取得
    key = pg.key.get_pressed()
    if(key[pg.K_RIGHT]):
        # 右向きキーが押された時、X座標を増やす
        player_rect.x += 10
    if(key[pg.K_LEFT]):
        # 左向きキーが押された時、X座標を減らす
        player_rect.x -= 10

    # キャラクターを表示
    screen.blit(player, player_rect)

    # 画面を更新
    pg.display.update()

    # ゲームの速度（FPS）を60に設定
    pg.time.Clock().tick(60)

    # イベントをチェック
    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 実行してみよう
左右の矢印キーを押して、忍者が動けば成功です！

## 解説：pg.time.Clock().tick(60)
この一行を追加することで、ゲームが動く速さを一定に保つことができます。「60」は1秒間に60回画面を更新するという意味です。これがないと、性能の良いパソコンではキャラクターが速く動きすぎてしまうことがあります。
