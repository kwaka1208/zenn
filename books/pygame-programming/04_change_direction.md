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
1. 前回作成した"game.py"を開きます。
1. 以下のコードの赤い枠の中を"game.py"に追加していきましょう。
1. 入力したら保存します。保存の操作は、ChromebookとWindowsの方は"Ctrl" + "S"、Macの方は"Command" + "S"です。プログラムの保存は最後にまとめてやるのではなく、ある程度入力したら保存するの方が良いです。もし入力途中でトラブルが起こったらせっかく入力したプログラムが消えてしまう可能性があります。

画像をクリックすると拡大表示されます（[こちらをクリックすると別ウインドウでオリジナルのソースコードが表示できます](https://github.com/kwaka1208/resources/blob/main/pygame/game04.py)）
[![](https://raw.githubusercontent.com/kwaka1208/resources/main/pygame/game04.png)](https://raw.githubusercontent.com/kwaka1208/resources/main/pygame/game04.png)

## 実行してみよう
プログラムの入力ができたら、プログラムを実行してみましょう。

## 考えてみよう
- フラグを使わずに、キーが押されたら必ず向きを変えるようなプログラムにするとどんな動きになるのか考えてみよう。


