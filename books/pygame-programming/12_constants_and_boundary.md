---
title: 定数と境界チェック
---
これまでのプログラムでは、画面のサイズ「800」や忍者のスピード「10」といった数字を直接書き込んできました。今回は、これらを「定数」として整理し、さらに忍者が画面の外に逃げないようにする「境界チェック」を学びます。

## 定数を使って整理しよう
プログラムの中に数字がバラバラに書かれていると、後で「画面を大きくしたい」と思ったときに、すべての数字を書き直すのが大変です。
そこで、プログラムの先頭で名前を付けて管理します。これを「定数」と呼び、慣習として大文字で書きます。

```python
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
PLAYER_SIZE = 100
PLAYER_SPEED = 10
```

## 境界チェックを追加しよう
忍者が画面の左端（0）や右端（800）を越えないように制限をかけます。

```python
if player_rect.left < 0:
    player_rect.left = 0
if player_rect.right > SCREEN_WIDTH:
    player_rect.right = SCREEN_WIDTH
```

## プログラムを入力しよう
`game.py` の先頭を定数で書き換え、移動処理の後に境界チェックを追加します。

### 全体のコード
```python
import pygame as pg
import sys
import random

# --- 定数 ---
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
PLAYER_SIZE = 100
PLAYER_SPEED = 10
ENEMY_SPEED = 10
BULLET_SPEED = 10

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
screen = pg.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT)) 

# キャラクター・弾・敵の準備（定数を使用）
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (PLAYER_SIZE, PLAYER_SIZE))
player_rect = pg.rect.Rect(0, SCREEN_HEIGHT - PLAYER_SIZE - 20, PLAYER_SIZE, PLAYER_SIZE)

bullet = pg.image.load("images/bullet.png")
bullet = pg.transform.scale(bullet, (30, 30))
bullet_rect = pg.rect.Rect(0, -10, 30, 30)

enemy = pg.image.load("images/enemy.png")
enemy = pg.transform.scale(enemy, (100, 100))
enemy_rect = pg.rect.Rect(random.randint(0, SCREEN_WIDTH - 100), 0, 100, 100)

fRight = True
hit = False
score = 0
hp = 3
font = pg.font.SysFont(None, 36)

while True:
    screen.fill(pg.Color("GRAY")) 
    display_info(score, hp)

    key = pg.key.get_pressed()
    # プレイヤーの移動
    if(key[pg.K_RIGHT]):
        player_rect.x += PLAYER_SPEED
        if(fRight == False):
            player = pg.transform.flip(player, True, False)
            fRight = True
    if(key[pg.K_LEFT]):
        player_rect.x -= PLAYER_SPEED
        if(fRight == True):
            player = pg.transform.flip(player, True, False)
            fRight = False

    # --- 境界チェック ---
    if player_rect.left < 0:
        player_rect.left = 0
    if player_rect.right > SCREEN_WIDTH:
        player_rect.right = SCREEN_WIDTH

    screen.blit(player, player_rect)

    # 弾の発射
    if key[pg.K_SPACE] and bullet_rect.y < 0:
        bullet_rect.x = player_rect.x + (PLAYER_SIZE // 2) - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    if bullet_rect.y >= 0:
        bullet_rect.y -= BULLET_SPEED
        if bullet_rect.y < -30:
            bullet_rect.y = -10
        screen.blit(bullet, bullet_rect)

    # 敵の移動
    enemy_rect.y += ENEMY_SPEED
    if enemy_rect.y > SCREEN_HEIGHT:
        if hit == True:
            enemy = pg.transform.flip(enemy, False, True)
            hit = False
        enemy_rect.x = random.randint(0, SCREEN_WIDTH - 100)
        enemy_rect.y = 0
    screen.blit(enemy, enemy_rect)

    # 当たり判定
    if enemy_rect.colliderect(bullet_rect) and hit == False:
      enemy = pg.transform.flip(enemy, False, True)
      hit = True
      bullet_rect.y = -10
      score += 10

    if enemy_rect.colliderect(player_rect):
      if hit != True:
        enemy_rect.y = SCREEN_HEIGHT + 1
        hp -= 1
        player_damage(player, player_rect)
        if hp <= 0:
            # （ゲームオーバー処理は11章と同じなので省略）
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

## 実行してみよう
忍者が画面の端でピタッと止まるようになれば成功です。
また、`PLAYER_SPEED` などの定数の数字を変えるだけで、ゲームの難易度が簡単に変えられることを試してみてください。
