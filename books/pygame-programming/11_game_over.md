---
title: ゲームオーバーと再プレイ
---
HPが0になったらゲームオーバーを表示し、再プレイするかどうかを選べるようにしましょう。

## プログラムを入力しよう
`game.py` にゲームオーバー表示用の関数と、ゲームオーバー時の選択処理を追加します。

### 変更点（diff）
```diff
+# ゲームオーバー表示用の関数
+def game_over(_score):
+  font = pg.font.SysFont(None, 72)
+  text_surface = font.render(f"GAME OVER", True, pg.Color("RED"))
+  screen.blit(text_surface, (50, 50))
+  font = pg.font.SysFont(None, 48)
+  text_surface = font.render(f"SCORE: {_score}", True, pg.Color("BLACK"))
+  screen.blit(text_surface, (50, 100))
+  text_surface = font.render(f"CONTINUE? Y / N", True, pg.Color("BLACK"))
+  screen.blit(text_surface, (50, 200))
+  pg.display.update()
```
```diff
     # 敵とプレイヤーの当たり判定（HP減少）
     if enemy_rect.colliderect(player_rect):
       if hit != True:
         enemy_rect.y = 601
         hp -= 1
         player_damage(player, player_rect)
+
+        # HPが0になったらゲームオーバー処理
+        if hp <= 0:
+          game_over(score)
+          status = 0
+          while True:
+            for event in pg.event.get():
+              if event.type == pg.KEYDOWN:
+                if event.key == pg.K_y:
+                  status = 1
+                  break
+                if event.key == pg.K_n:
+                  status = 2
+                  break
+              if event.type == pg.QUIT:
+                  status = 2
+                  break
+            if status != 0:
+              break
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

# ゲームオーバー表示用の関数
def game_over(_score):
  font_lg = pg.font.SysFont(None, 72)
  text_surface = font_lg.render(f"GAME OVER", True, pg.Color("RED"))
  screen.blit(text_surface, (50, 50))
  font_md = pg.font.SysFont(None, 48)
  text_surface = font_md.render(f"SCORE: {_score}", True, pg.Color("BLACK"))
  screen.blit(text_surface, (50, 100))
  text_surface = font_md.render(f"CONTINUE? Y / N", True, pg.Color("BLACK"))
  screen.blit(text_surface, (50, 200))
  pg.display.update()

# pygame初期化
pg.init()
screen = pg.display.set_mode((800, 600)) 

# キャラクター・弾・敵の読み込み
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (100, 100))
player_rect = pg.rect.Rect(0, 480, 100, 100)
bullet = pg.image.load("images/bullet.png")
bullet = pg.transform.scale(bullet, (30, 30))
bullet_rect = pg.rect.Rect(0, -10, 30, 30)
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
    display_info(score, hp)

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
      score += 10

    if enemy_rect.colliderect(player_rect):
      if hit != True:
        enemy_rect.y = 601
        hp -= 1
        player_damage(player, player_rect)

        # HPが0になった時の処理
        if hp <= 0:
          game_over(score)
          status = 0 # 0:待機 1:リスタート 2:終了
          while True:
            for event in pg.event.get():
              if event.type == pg.KEYDOWN:
                if event.key == pg.K_y: # Yキーで再開
                  status = 1
                  break
                if event.key == pg.K_n: # Nキーで終了
                  status = 2
                  break
              if event.type == pg.QUIT:
                  status = 2
                  break

            if status == 1:
              score = 0
              hp = 3
              break
            elif status == 2:
              pg.quit()
              sys.exit()
        continue

    pg.display.update()
    pg.time.Clock().tick(60)

    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
```

## 解説：ゲームオーバー時の待機ループ
HPが0になったとき、そのままプログラムを終わらせるのではなく、別の「待ち（while）」ループに入れています。ここでプレイヤーが `Y` キーを押すまで待機し、押されたらスコアとHPをリセットしてメインのループに戻る（break）という仕組みです。

## 完成！
これで、Pygameを使った基本的なシューティングゲームが完成しました。
ここから敵の種類を増やしたり、ステージを作ったりして、自分だけのゲームに改造してみてください！

