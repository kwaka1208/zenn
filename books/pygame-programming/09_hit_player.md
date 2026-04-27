---
title: プレイヤーの当たり判定を作ろう
---
敵がプレイヤーに当たった時の処理を追加します。今回は、当たった時にプレイヤーが点滅（反転）するようなダメージ演出を作ってみましょう。

## 関数（def）を使ってみよう
ダメージを受けた時の演出のように、決まった処理を何度も使いたい場合は「関数」としてまとめると便利です。Pythonでは `def` を使って関数を作ります。

```python
def player_damage(_player, _player_rect):
  # ダメージを受けた時の演出
  for i in range(10):
    _player = pg.transform.flip(_player, True, False) # 反転
    screen.blit(_player, _player_rect)
    pg.display.update()
    pg.time.wait(100) # 少し待つ
    screen.fill(pg.Color("GRAY")) # 画面をクリア
```

関数は「呼び出す（使う）」よりも前に「定義（作成）」しておく必要があるため、プログラムの最初の方に書くのが一般的です。

## プログラムを入力しよう
`game.py` の先頭付近に関数を定義し、ループ内で当たり判定の処理を追加します。

### 変更点（diff）
```diff
 import sys
 import random

+# プレイヤーのダメージ処理（関数）
+def player_damage(_player, _player_rect):
+  for i in range(10):
+    _player = pg.transform.flip(_player, True, False)
+    screen.blit(_player, _player_rect)
+    pg.display.update()
+    pg.time.wait(100)
+    screen.fill(pg.Color("GRAY")) 
+
 # pygame初期化
```
```diff
       bullet_rect.y = -10
+
+    # 敵とプレイヤーの当たり判定
+    if enemy_rect.colliderect(player_rect):
+      # 弾に当たって落ちてきた敵とは当たらないようにする
+      if hit != True:
+        # 敵を画面外へ（消去）
+        enemy_rect.y = 601
+        # ダメージ演出関数を呼び出す
+        player_damage(player, player_rect)
+        # ループの最初に戻る
+        continue
```

### 全体のコード
```python
import pygame as pg
import sys
import random

# プレイヤーのダメージ処理
def player_damage(_player, _player_rect):
  for i in range(10):
    _player = pg.transform.flip(_player, True, False)
    screen.blit(_player, _player_rect)
    pg.display.update()
    pg.time.wait(100)
    screen.fill(pg.Color("GRAY")) 

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

fRight = True
hit = False

while True:
    screen.fill(pg.Color("GRAY")) 

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

    if key[pg.K_SPACE] and bullet_rect.y < 0:
        bullet_rect.x = player_rect.x + 50 - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    if bullet_rect.y >= 0:
        bullet_rect.y -= 10
        if bullet_rect.y < -30:
            bullet_rect.y = -10
        screen.blit(bullet, bullet_rect)

    enemy_rect.y += 10
    if enemy_rect.y > 600:
        if hit == True:
            enemy = pg.transform.flip(enemy, False, True)
            hit = False
        enemy_rect.x = random.randint(0, 800)
        enemy_rect.y = 0
    screen.blit(enemy, enemy_rect)

    if enemy_rect.colliderect(bullet_rect) and hit == False:
      enemy = pg.transform.flip(enemy, False, True)
      hit = True
      bullet_rect.y = -10

    # 敵とプレイヤーの当たり判定
    if enemy_rect.colliderect(player_rect):
      if hit != True:
        enemy_rect.y = 601
        player_damage(player, player_rect)
        continue

    pg.display.update()
    pg.time.Clock().tick(60)

    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 実行してみよう
おばけ（敵）に体当たりされたときに、忍者がチカチカ点滅すれば成功です！

