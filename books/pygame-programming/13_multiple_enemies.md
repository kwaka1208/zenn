---
title: たくさんの敵を登場させよう
---
今のゲームは敵が1体しか出てこないので、少し寂しいですね。今回はPythonの「リスト」を使って、たくさんの敵とたくさんの弾を扱えるように改造します。

## リストでオブジェクトを管理しよう
これまでは `enemy_rect` という1つの変数で管理していましたが、これをリストにします。

```python
enemies = [] # 敵をいれるリスト
for i in range(5):
    rect = pg.rect.Rect(random.randint(0, SCREEN_WIDTH - 100), random.randint(-500, 0), 100, 100)
    enemies.append(rect)
```

## プログラムを入力しよう
弾もリスト（`bullets = []`）で管理するようにして、複数の弾を連射できるようにします。

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
ENEMY_SPEED = 5
BULLET_SPEED = 15

# プレイヤーのダメージ演出
def player_damage(_player, _player_rect):
  for i in range(5):
    _player = pg.transform.flip(_player, True, False)
    screen.blit(_player, _player_rect)
    pg.display.update()
    pg.time.wait(50)
    screen.fill(pg.Color("GRAY")) 

# 情報表示
def display_info(_score, _hp):
    text_surface = font.render(f"SCORE: {_score}", True, pg.Color("BLACK"))
    screen.blit(text_surface, (50, 50))
    text_surface = font.render(f"HP: {_hp}", True, pg.Color("BLACK"))
    screen.blit(text_surface, (50, 100))

# pygame初期化
pg.init()
screen = pg.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT)) 

# キャラクター準備
player = pg.image.load("images/ninja.png")
player = pg.transform.scale(player, (PLAYER_SIZE, PLAYER_SIZE))
player_rect = pg.rect.Rect(SCREEN_WIDTH // 2, SCREEN_HEIGHT - PLAYER_SIZE - 20, PLAYER_SIZE, PLAYER_SIZE)

# 画像の読み込み
bullet_img = pg.image.load("images/bullet.png")
bullet_img = pg.transform.scale(bullet_img, (30, 30))
enemy_img = pg.image.load("images/enemy.png")
enemy_img = pg.transform.scale(enemy_img, (80, 80))

# リストの準備
bullets = []
enemies = []
for i in range(5):
    rect = pg.rect.Rect(random.randint(0, SCREEN_WIDTH-80), random.randint(-600, 0), 80, 80)
    enemies.append({"rect": rect, "hit": False})

fRight = True
score = 0
hp = 10
font = pg.font.SysFont(None, 36)

while True:
    screen.fill(pg.Color("GRAY")) 
    display_info(score, hp)

    key = pg.key.get_pressed()
    if(key[pg.K_RIGHT]):
        player_rect.x += PLAYER_SPEED
        if not fRight:
            player = pg.transform.flip(player, True, False)
            fRight = True
    if(key[pg.K_LEFT]):
        player_rect.x -= PLAYER_SPEED
        if fRight:
            player = pg.transform.flip(player, True, False)
            fRight = False

    if player_rect.left < 0: player_rect.left = 0
    if player_rect.right > SCREEN_WIDTH: player_rect.right = SCREEN_WIDTH

    screen.blit(player, player_rect)

    # 弾の発射（スペースキーで追加）
    for event in pg.event.get():
        if event.type == pg.QUIT:
            pg.quit()
            sys.exit()
        if event.type == pg.KEYDOWN:
            if event.key == pg.K_SPACE:
                new_bullet = pg.rect.Rect(player_rect.x + 35, player_rect.y, 30, 30)
                bullets.append(new_bullet)
                pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()

    # 弾の移動と描画
    for b in bullets[:]:
        b.y -= BULLET_SPEED
        if b.y < -30:
            bullets.remove(b)
        else:
            screen.blit(bullet_img, b)

    # 敵の移動と当たり判定
    for e in enemies:
        e["rect"].y += ENEMY_SPEED
        
        # 画面外に出たら復活
        if e["rect"].y > SCREEN_HEIGHT:
            e["rect"].x = random.randint(0, SCREEN_WIDTH-80)
            e["rect"].y = random.randint(-200, 0)
            e["hit"] = False

        # 弾との当たり判定
        for b in bullets[:]:
            if e["rect"].colliderect(b) and not e["hit"]:
                e["hit"] = True
                bullets.remove(b)
                score += 10
        
        # プレイヤーとの当たり判定
        if e["rect"].colliderect(player_rect) and not e["hit"]:
            hp -= 1
            e["rect"].y = SCREEN_HEIGHT + 1
            player_damage(player, player_rect)

        # 敵の描画
        if not e["hit"]:
            screen.blit(enemy_img, e["rect"])
        else:
            # 倒された演出（ひっくり返って落ちるなど）
            rotated_enemy = pg.transform.flip(enemy_img, False, True)
            screen.blit(rotated_enemy, e["rect"])

    pg.display.update()
    pg.time.Clock().tick(60)
```

## 解説：リストの力
リストを使うことで、同じ種類のオブジェクトを `for` ループで一気に処理できるようになります。これで「敵が100体」になっても、プログラムの長さはほとんど変わりません。

## 試してみよう
- 敵の数（`range(5)` の数字）を10や20に増やしてみましょう。
- 弾を連射できるようにしたので、一度にたくさんの敵を倒せるはずです！
