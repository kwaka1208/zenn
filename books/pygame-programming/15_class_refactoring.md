---
title: クラスを使って本格的な設計に挑戦！
---
最後のステップとして、プログラムを「クラス（Class）」を使って整理します。今は1つのファイルにすべての処理が書かれていますが、クラスを使うことで「プレイヤー」「敵」「弾」といった役割ごとにプログラムを切り分けることができます。

## なぜクラスを使うのか？
ゲームが大きくなってくると、「忍者が2人になったら？」「敵の種類が3種類になったら？」というときに、今の書き方だと非常に複雑になってしまいます。
クラスを使えば、設計図（クラス）を1つ作っておくだけで、同じ性質を持ったオブジェクトを簡単にいくつでも作れるようになります。

## クラスの書き方の例
例えば、弾のクラスは以下のようになります。

```python
class Bullet:
    def __init__(self, x, y):
        self.rect = pg.rect.Rect(x, y, 30, 30)
        
    def update(self):
        self.rect.y -= BULLET_SPEED
        
    def draw(self, screen):
        screen.blit(bullet_img, self.rect)
```

## 本格的なゲームコード
すべての要素をクラスにまとめた、このBookの最終到達点となるコードです。

```python
import pygame as pg
import sys
import random

# 定数
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
PLAYER_SIZE = 100

# --- クラス定義 ---

class Player(pg.sprite.Sprite):
    def __init__(self):
        super().__init__()
        self.image = pg.image.load("images/ninja.png")
        self.image = pg.transform.scale(self.image, (PLAYER_SIZE, PLAYER_SIZE))
        self.rect = self.image.get_rect(midbottom=(SCREEN_WIDTH//2, SCREEN_HEIGHT-20))
        self.speed = 10
        self.hp = 3

    def update(self, keys):
        if keys[pg.K_LEFT] and self.rect.left > 0:
            self.rect.x -= self.speed
        if keys[pg.K_RIGHT] and self.rect.right < SCREEN_WIDTH:
            self.rect.x += self.speed

class Enemy(pg.sprite.Sprite):
    def __init__(self):
        super().__init__()
        self.image = pg.image.load("images/enemy.png")
        self.image = pg.transform.scale(self.image, (80, 80))
        self.rect = self.image.get_rect(center=(random.randint(0, SCREEN_WIDTH), random.randint(-100, 0)))
        self.speed = random.randint(3, 7)

    def update(self):
        self.rect.y += self.speed
        if self.rect.top > SCREEN_HEIGHT:
            self.rect.center = (random.randint(0, SCREEN_WIDTH), random.randint(-100, 0))

class Bullet(pg.sprite.Sprite):
    def __init__(self, x, y):
        super().__init__()
        self.image = pg.image.load("images/bullet.png")
        self.image = pg.transform.scale(self.image, (30, 30))
        self.rect = self.image.get_rect(center=(x, y))

    def update(self):
        self.rect.y -= 15
        if self.rect.bottom < 0:
            self.kill()

# --- メイン処理 ---

def main():
    pg.init()
    screen = pg.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    clock = pg.time.Clock()
    font = pg.font.SysFont(None, 36)

    # グループ管理（Pygameの便利な機能）
    player = Player()
    enemies = pg.sprite.Group([Enemy() for _ in range(5)])
    bullets = pg.sprite.Group()
    score = 0

    while True:
        screen.fill(pg.Color("GRAY"))
        keys = pg.key.get_pressed()

        # イベント処理
        for event in pg.event.get():
            if event.type == pg.QUIT:
                return
            if event.type == pg.KEYDOWN:
                if event.key == pg.K_SPACE:
                    bullets.add(Bullet(player.rect.centerx, player.rect.top))

        # 更新
        player.update(keys)
        enemies.update()
        bullets.update()

        # 当たり判定（Spriteグループを使うと超簡単！）
        if pg.sprite.groupcollide(bullets, enemies, True, True):
            score += 10
            enemies.add(Enemy())

        if pg.sprite.spritecollide(player, enemies, True):
            player.hp -= 1
            enemies.add(Enemy())
            if player.hp <= 0:
                print(f"Game Over! Score: {score}")
                return

        # 描画
        screen.blit(player.image, player.rect)
        enemies.draw(screen)
        bullets.draw(screen)
        
        # 情報表示
        score_text = font.render(f"SCORE: {score}  HP: {player.hp}", True, "BLACK")
        screen.blit(score_text, (20, 20))

        pg.display.update()
        clock.tick(60)

if __name__ == "__main__":
    main()
    pg.quit()
```

## まとめ
クラスと「スプライト（Sprite）」という機能を使うことで、当たり判定やオブジェクトの管理が驚くほど簡単になりました。
これが、プロの現場でも使われる「オブジェクト指向」という考え方の入り口です。

お疲れ様でした！これであなたもPygameマスターの第一歩を踏み出しました。
