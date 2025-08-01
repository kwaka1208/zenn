---
title: プレイヤーの当たり判定を作ろう
---
プレイヤーに敵キャラクターにが当たったかどうかを判定し、当たった時の処理を追加します。

## プログラム全体
[こちらをクリックすると別ウインドウでオリジナルのソースコードが表示できます](https://github.com/kwaka1208/resources/blob/main/pygame/game08.py)

## 前回からの変更箇所
前回からの変更箇所は以下の通りです。

### プレイヤーに敵が当たった時の処理を追加しよう
> 全体プログラムの5〜20行目です。

![](/images/python/pygame/08/01.png)

プログラムの一番最初にプレイヤーに敵が当たった時の処理を関数として追加します。

この関数には判定処理は含まれていません。判定した結果、キャラクターを左右に反転する処理を10回繰り返す処理だけが含まれています。

## 敵がプレイヤーにあたったかどうかを判定しよう
> プログラムの117〜126行目です。

![](/images/python/pygame/08/02.png)

プレイヤーキャラに敵キャラがあたったかどうかを判定し、当たった当たった時の処理関数(player_damage)を呼び出します。

関数は呼び出しよりも前に書かれていないといけないので、プログラムの一番最初に書いています。

## プログラムを入力しよう
1. 前回作成した"game.py"を開きます。
1. 前回からの変更部分を"game.py"に追加していきましょう。
1. 入力したら保存します。保存の操作は、ChromebookとWindowsの方は"Ctrl" + "S"、Macの方は"Command" + "S"です。プログラムの保存は最後にまとめてやるのではなく、ある程度入力したら保存するの方が良いです。もし入力途中でトラブルが起こったらせっかく入力したプログラムが消えてしまう可能性があります。

## 実行してみよう
プログラムの入力ができたら、プログラムを実行してみましょう。
