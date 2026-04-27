---
title: 敵キャラクターを追加して動かそう
---
敵キャラクターを追加します。敵キャラクターは画面の上にランダムに登場し、下に向かって体当たり攻撃をしかけてきます。

## 手順
### 敵の画像を追加しよう
1. 敵の画像を追加します。ここでは[ドッタウン](https://dotown.maeda-design-room.net/)の[おばけ](https://dotown.maeda-design-room.net/1704/)の画像を使います。
2. ダウンロードしたファイルの名前を `enemy.png` に変更してください。
3. `images` フォルダの中へ保存します。

## プログラムを入力しよう
`game.py` に `random` モジュールのインポート、敵キャラクターの設定、スペースキーによる発射処理を追加します。
また、背景色を「WHITE」から「GRAY」に変更して、ゲーム画面らしくしてみましょう。

### 変更点（diff）
```diff
 import pygame as pg
 import sys
+import random
```
```diff
 # 弾追加
 bullet = pg.image.load("images/bullet.png")
 bullet = pg.transform.scale(bullet, (30, 30))
 bullet_rect = pg.rect.Rect(0, -10, 30, 30)
 
+# 敵追加
+enemy = pg.image.load("images/enemy.png")
+enemy = pg.transform.scale(enemy, (100, 100))
+enemy_rect = pg.rect.Rect(random.randint(0, 800), 0, 100, 100)
+
 # 右を向いているかどうかのフラグ
```
```diff
 while True:
-    # 画面を白で塗りつぶす
-    screen.fill(pg.Color("WHITE")) 
+    # 画面をグレーで塗りつぶす
+    screen.fill(pg.Color("GRAY")) 
```
```diff
-    fire = pg.mouse.get_pressed()
-    # マウスの左ボタンが押された時に、弾が発射されていなかったら
-    if fire[0] and bullet_rect.y < 0:
+    # スペースキーが押された時に、弾が発射されていなかったら
+    if key[pg.K_SPACE] and bullet_rect.y < 0:
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

# 右を向いているかどうかのフラグ
# 右向き：True 左向き：False（右向きじゃない）
fRight = True

while True:
    # 画面をグレーで塗りつぶす
    screen.fill(pg.Color("GRAY")) 

    # キー入力の情報を取得
    key = pg.key.get_pressed()
    if(key[pg.K_RIGHT]):
        # 右向きキーが押された時、X座標を増やす
        player_rect.x += 10
        if(fRight == False):
            # 右向きでなければ、左向きから右向きに変更
            player = pg.transform.flip(player, True, False)
            fRight = True
    if(key[pg.K_LEFT]):
        # 左向きキーが押された時、X座標を減らす
        player_rect.x -= 10
        if(fRight == True):
            # 右向きなら、右向きから左向きに変更
            player = pg.transform.flip(player, True, False)
            fRight = False

    # キャラクターを表示
    screen.blit(player, player_rect)

    # スペースキーが押された時に、弾が発射されていなかったら
    if key[pg.K_SPACE] and bullet_rect.y < 0:
        # 弾の初期位置を設定
        bullet_rect.x = player_rect.x + 50 - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    if bullet_rect.y >= 0:
        # 弾を上に移動
        bullet_rect.y -= 10
        if bullet_rect.y < -30: # 画面外に出たら発射可能にする
            bullet_rect.y = -10
        screen.blit(bullet, bullet_rect)

    ## 敵の処理
    enemy_rect.y += 10
    if enemy_rect.y > 600:
        # 画面の下に到達したら、上から再登場
        enemy_rect.x = random.randint(0, 800)
        enemy_rect.y = 0
    screen.blit(enemy, enemy_rect)

    # 画面を更新
    pg.display.update()

    pg.time.Clock().tick(60)

    # イベントをチェック
    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 実行してみよう
スペースキーで弾が出るようになり、上からおばけ（敵）が降ってくれば成功です！

## 考えてみよう
- 敵キャラクターの降ってくるスピードを速くするには、どの数字を変えればいいでしょうか？


