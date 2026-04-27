---
title: スコアとHPを表示しよう
---
ゲームをより面白くするために、スコア（得点）とHP（体力）を追加しましょう。また、現在のスコアやHPを画面上に文字として表示します。

## プログラムを入力しよう
`game.py` にスコアとHPの変数、フォントの設定、そして画面表示用の関数を追加します。

### 変更点（diff）
```diff
 # 当たった：True 当たっない：False
 hit = False

+# スコアを記録する変数
+score = 0
+
+# HP（体力）を記録する変数
+hp = 3
+
+# 文字を表示するためのフォントを設定
+font = pg.font.SysFont(None, 36)
+
+# 情報表示用の関数
+def display_info(_score, _hp):
+    text_surface = font.render(f"SCORE: {_score}", True, pg.Color("BLACK"))
+    screen.blit(text_surface, (50, 50))
+    text_surface = font.render(f"HP: {_hp}", True, pg.Color("BLACK"))
+    screen.blit(text_surface, (50, 100))
+
 while True:
```
```diff
     if enemy_rect.colliderect(bullet_rect) and hit == False:
       enemy = pg.transform.flip(enemy, False, True)
       hit = True
       bullet_rect.y = -10
+      score += 10 # 敵を倒したらスコアアップ
```
```diff
     # 敵とプレイヤーの当たり判定
     if enemy_rect.colliderect(player_rect):
       if hit != True:
         enemy_rect.y = 601
+        hp -= 1 # ダメージを受けたらHPを減らす
         player_damage(player, player_rect)
         continue
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

# スコアとHPを表示する関数
def display_info(_score, _hp):
    text_surface = font.render(f"SCORE: {_score}", True, pg.Color("BLACK"))
    screen.blit(text_surface, (50, 50))
    text_surface = font.render(f"HP: {_hp}", True, pg.Color("BLACK"))
    screen.blit(text_surface, (50, 100))

# pygame初期化
pg.init()
screen = pg.display.set_mode((800, 600)) 

# キャラクター追加
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (100, 100))
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
score = 0
hp = 3
font = pg.font.SysFont(None, 36)

while True:
    screen.fill(pg.Color("GRAY")) 

    # 情報の表示
    display_info(score, hp)

    key = pg.key.get_pressed()
    # プレイヤーの移動（左右）
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

    # 弾の発射
    if key[pg.K_SPACE] and bullet_rect.y < 0:
        bullet_rect.x = player_rect.x + 50 - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    if bullet_rect.y >= 0:
        bullet_rect.y -= 10
        if bullet_rect.y < -30:
            bullet_rect.y = -10
        screen.blit(bullet, bullet_rect)

    # 敵の移動
    enemy_rect.y += 10
    if enemy_rect.y > 600:
        if hit == True:
            enemy = pg.transform.flip(enemy, False, True)
            hit = False
        enemy_rect.x = random.randint(0, 800)
        enemy_rect.y = 0
    screen.blit(enemy, enemy_rect)

    # 敵と弾の当たり判定（スコア加算）
    if enemy_rect.colliderect(bullet_rect) and hit == False:
      enemy = pg.transform.flip(enemy, False, True)
      hit = True
      bullet_rect.y = -10
      score += 10

    # 敵とプレイヤーの当たり判定（HP減少）
    if enemy_rect.colliderect(player_rect):
      if hit != True:
        enemy_rect.y = 601
        hp -= 1
        player_damage(player, player_rect)
        continue

    pg.display.update()
    pg.time.Clock().tick(60)

    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 解説：font.render の仕組み
Pygameで文字を表示するには、以下の3ステップが必要です。
1. `pg.font.SysFont` で使いたいフォントと大きさを決める。
2. `font.render` で表示したい文字、滑らかにするか、色を決めて「文字の画像（Surface）」を作る。
3. `screen.blit` でその画像を画面の好きな場所に貼り付ける。

直接 `screen.print` のように書くことはできないので、この手順を覚えておきましょう。

## 実行してみよう
画面の左上に「SCORE」と「HP」が表示され、敵を倒すとスコアが増え、体当たりされるとHPが減れば成功です！

