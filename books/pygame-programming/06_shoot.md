---
title: 弾を発射しよう
---
キャラクターに弾を発射させます。弾の発射は以下の仕様とします。

- マウスの左クリックを押した時に弾を発射する
- 弾を発射する

## 手順
### 弾の画像を追加しよう
1. 弾の画像を追加します。ここでは[ドッタウン](https://dotown.maeda-design-room.net/)の[ヘ音記号](https://dotown.maeda-design-room.net/3200/)の画像を使います。
2. ダウンロードしたファイルの名前を `bullet.png` に変更してください。
3. `images` フォルダの中へ保存します。

### 効果音を追加しよう
1. 発射音の音声データを追加します。ここでは[魔王魂](https://maou.audio/)の[戦闘効果音](https://maou.audio/category/se/se-battle/)から「戦闘17」を使わせていただきました。
2. プロジェクトフォルダの中に `sounds` フォルダを作成します。
3. ダウンロードしたファイルを `sounds` フォルダの中へ保存し、名前を `maou_se_battle17.mp3` に変更してください。

フォルダ構成は以下のようになります。
```text
プロジェクトフォルダ/
├── game.py
├── images/
│   ├── ninja.png
│   └── bullet.png
└── sounds/
    └── maou_se_battle17.mp3
```

## プログラムを入力しよう
`game.py` に弾の読み込みと、マウス操作による発射処理を追加します。

### 変更点（diff）
```diff
 player_rect = pg.rect.Rect(0, 480, 100, 100)
 
+# 弾追加
+bullet = pg.image.load("images/bullet.png")
+bullet = pg.transform.scale(bullet, (30, 30))
+bullet_rect = pg.rect.Rect(0, -10, 30, 30)
+
 # 右を向いているかどうかのフラグ
```
```diff
     # キャラクターを表示
     screen.blit(player, player_rect)
 
+    fire = pg.mouse.get_pressed()
+    # マウスの左ボタンが押された時に、弾が発射されていなかったら
+    if fire[0] and bullet_rect.y < 0:
+        # 弾の初期位置を設定（忍者の位置に合わせる）
+        bullet_rect.x = player_rect.x + 50 - 15
+        bullet_rect.y = player_rect.y
+        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()
+
+    if bullet_rect.y >= 0:
+        # 弾を上に移動
+        bullet_rect.y -= 10
+        screen.blit(bullet, bullet_rect)
+
     # 画面を更新
```

### 全体のコード
```python
import pygame as pg
import sys

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


# 右を向いているかどうかのフラグ
# 右向き：True 左向き：False（右向きじゃない）
fRight = True

while True:
    # 画面を白で塗りつぶす
    screen.fill(pg.Color("WHITE")) 

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

    fire = pg.mouse.get_pressed()
    # マウスの左ボタンが押された時に、弾が発射されていなかったら
    if fire[0] and bullet_rect.y < 0:
        # 弾の初期位置を設定
        bullet_rect.x = player_rect.x + 50 - 15
        bullet_rect.y = player_rect.y
        pg.mixer.Sound("sounds/maou_se_battle17.mp3").play()
    if bullet_rect.y >= 0:
        # 弾を上に移動
        bullet_rect.y -= 10
        screen.blit(bullet, bullet_rect)

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
忍者を左右に動かしながら、マウスを左クリックして弾が飛んでいけば成功です！

## 考えてみよう
- 弾が同時に1発しか出せないようになっているのは、プログラムのどの部分が関係しているか考えてみましょう。

## 考えてみよう
- 弾のX座標を計算している部分がありますが、なぜこのような計算を行なっているのか考えてみましょう。


