---
title: キャラクターの向きを変えてみよう
---
次にキャラクターを操作した時に向きを変えてみましょう。

## キャラクターの向きを管理するフラグを作る
> プログラムの16〜18行目です。

Scratchとなどと違ってpygameにはキャラクターがどっちを向いているのかを管理するキャラクターするための情報（フラグ）をプログラムの中で作る必要があります。

フラグとは変数の使い方の一種で、プログラムの中の色々な状態を管理するために使われるものです。

今回は、キャラクターが右を向いているかどうかを管理するフラグ"fRight"を作ります。

> fRight：True （右を向いている）
> fRight：False （右を向いていない、つまり左を向いている）

TrueとFalseはプログラミングの世界でよく使われる情報の表し方です。Trueは「真（その通り）」、Falseは「偽（違う）」を意味します。

Scratchを例に説明しましょう。以下のブロックでは変数に50を入れた状態で、変数の中身を演算ブロックを使って調べています。

左側のブロックは変数の中身が50かどうかを調べています。変数の中身が50なので、True（その通り）という結果になります。

![](/images/python/pygame/scratch01.png)

右側のブロックは変数の中身が49かどうかを調べています。変数の中身が50なので、False（違う）という結果になります。

![](/images/python/pygame/scratch02.png)

これと同じ考え方で、今回はキャラクターが右を向いているかどうかを管理するフラグ"fRight"を作って以下の通りの意味にしています。

> fRight：True （右を向いている）
> fRight：False （右を向いていない、つまり左を向いている）

## カーソルキーの右を押した時、左を向いていれば右に向きを変える
> プログラムの29〜32行目です。

カーソルキーの右を押した時、fRightの値が"False"の場合は右向きではない（つまり左向き）なので、左右の向きを変えてfRightの値を"True"にします。

> player = pg.transform.flip(player, True, False)

1つめのTrueは左右の向きを反転するという意味です。この命令を実行するとキャラクター（の画像の）向きが左右反対になります。2つ目のFalseをTrueに変えると上下の向きを反転します。

## カーソルキーの左を押した時、右を向いていれば左に向きを変える
> プログラムの36〜39行目です。

考え方は右を押した時と同じです。
カーソルキーの左を押した時、fRightの値が"True"の場合は右向きなので、左右の向きを変えてfRightの値を"False"にします。

## プログラムを入力しよう
`game.py` に向きを管理するフラグと、反転の処理を追加します。

### 変更点（diff）
```diff
+# 右を向いているかどうかのフラグ
+# 右向き：True 左向き：False（右向きじゃない）
+fRight = True
+
 while True:
     # 画面を白で塗りつぶす
     screen.fill(pg.Color("WHITE")) 
 
     # キー入力の情報を取得
     key = pg.key.get_pressed()
     if(key[pg.K_RIGHT]):
         # 右向きキーが押された時、X座標を増やす
         player_rect.x += 10
+        if(fRight == False):
+            # 右向きでなければ、左向きから右向きに変更
+            player = pg.transform.flip(player, True, False)
+            fRight = True
     if(key[pg.K_LEFT]):
         # 左向きキーが押された時、X座標を減らす
         player_rect.x -= 10
+        if(fRight == True):
+            # 右向きなら、右向きから左向きに変更
+            player = pg.transform.flip(player, True, False)
+            fRight = False
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
左右に動かしたときに、忍者の向きがちゃんと変われば成功です！

## 考えてみよう
- フラグを使わずに、キーが押されたら必ず向きを変えるようなプログラムにするとどんな動きになるのか考えてみよう。


