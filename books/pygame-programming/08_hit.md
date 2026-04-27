---
title: 敵の当たり判定を作ろう
---
敵キャラクターに弾が当たったかどうかを判定し、当たった時の処理を追加します。

## 手順
### フラグを追加しよう
敵に弾が当たったかどうかを記憶するためのフラグ `hit` を追加します。

## 当たり判定を追加しよう
敵キャラに弾があたったかどうかを判定し、当たった時の処理を追加します。

当たり判定には、`colliderect` という関数を使います。

```python
enemy_rect.colliderect(bullet_rect)
```

この命令は、2つの四角形（矩形）が重なっているかどうかを調べてくれます。重なっていれば `True`、重なっていなければ `False` を返します。

当たった（重なった）ときは、以下の処理を行います。
1. 敵キャラクターを上下反転させる（やられた演出）。
2. `hit` フラグを `True` にする。
3. 弾を画面外に移動させる。

## プログラムを入力しよう
`game.py` に当たり判定の処理を追加しましょう。

### 変更点（diff）
```diff
 # 右を向いているかどうかのフラグ
 # 右向き：True 左向き：False（右向きじゃない）
 fRight = True

+# 弾が敵にあたったかどうかのフラグ
+hit = False
+
 while True:
```
```diff
     ## 敵の処理
     enemy_rect.y += 10

-    if enemy_rect.y > 600:
-        enemy_rect.x = random.randint(0, 800)
-        enemy_rect.y = 0
-    screen.blit(enemy, enemy_rect)
+    # 敵が画面外に出たら、初期位置に戻す
+    if enemy_rect.y > 600:
+        if hit == True:
+            # 敵が弾に当たっていたら、向きを元に戻す
+            enemy = pg.transform.flip(enemy, False, True)
+            hit = False
+        enemy_rect.x = random.randint(0, 800)
+        enemy_rect.y = 0
+    screen.blit(enemy, enemy_rect)
+
+    # 敵と弾の当たり判定
+    if enemy_rect.colliderect(bullet_rect) and hit == False:
+        # 当たったら敵をひっくり返す
+        enemy = pg.transform.flip(enemy, False, True)
+        hit = True
+        # 弾を画面外へ
+        bullet_rect.y = -10
```

### 全体のコード
```python
import pygame as pg
import sys
import random

# pygame初期化
pg.init()

# 画面設定
screen = pg.display.set_mode((800, 600)) 

# キャラクター追加
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (100, 100))
player = pg.transform.flip(player, True, False)
player_rect = pg.rect.Rect(0, 480, 100, 100)

# 弾追加
bullet = pg.image.load("images/bullet.png")
bullet = pg.transform.scale(bullet, (30, 30))
bullet_rect = pg.rect.Rect(0, -10, 30, 30)

# 敵追加
enemy = pg.image.load("images/enemy.png")
enemy = pg.transform.scale(enemy, (100, 100))
enemy_rect = pg.rect.Rect(random.randint(0, 800), 0, 100, 100)

# フラグの設定
fRight = True # プレイヤーの向き
hit = False   # 敵に当たったか

while True:
    # 画面をグレーで塗りつぶす
    screen.fill(pg.Color("GRAY")) 

    # キー入力
    key = pg.key.get_pressed()
    if(key[pg.K_RIGHT]):
        player_rect.x += 10
        if(fRight == False):
            player = pg.transform.flip(player, True, False)
            fRight = True
    if(key[pg.K_LEFT]):
        player_rect.x -= 10
        if(fRight == True):
            player = pg.transform.flip(player, True, False)
            fRight = False

    screen.blit(player, player_rect)

    # 弾の発射（スペースキー）
    if key[pg.K_SPACE] and bullet_rect.y < 0:
        bullet_rect.x = player_rect.x + 50 - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    if bullet_rect.y >= 0:
        bullet_rect.y -= 10
        if bullet_rect.y < -30:
            bullet_rect.y = -10
        screen.blit(bullet, bullet_rect)

    ## 敵の処理
    enemy_rect.y += 10
    if enemy_rect.y > 600:
        if hit == True:
            # 復活時に向きを元に戻す
            enemy = pg.transform.flip(enemy, False, True)
            hit = False
        enemy_rect.x = random.randint(0, 800)
        enemy_rect.y = 0
    screen.blit(enemy, enemy_rect)

    # 当たり判定
    if enemy_rect.colliderect(bullet_rect) and hit == False:
        enemy = pg.transform.flip(enemy, False, True)
        hit = True
        bullet_rect.y = -10

    # 画面を更新
    pg.display.update()
    pg.time.Clock().tick(60)

    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 実行してみよう
おばけ（敵）に弾を当てて、おばけがひっくり返れば成功です！
これでゲームの基本システムが出来上がりました。



