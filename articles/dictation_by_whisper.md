---
title: WhisperとGoogle Colaboratoryを使って文字起こし
emoji: 👂
type: tech
topics: [whisper, dictation, Google colabo]
published: true
---
## はじめに
この記事では、WhisperをGoogle Colaboratoryで動かして、音声データから文字起こしをするプログラムとその使い方を説明しています。このプログラムを利用するには、Googleアカウントが必要です。

## 使い方
1. Google Driveのマイドライブの下に"whisper"というフォルダを作成します。
2. このフォルダに文字起こししたい音声データを置きます。複数まとめて処理ができますが、Google Colaboratoryの実行時間に制限があるはずなので、ひとつずつやった方が良いかもしれません。
3. [こちらのプログラム](https://colab.research.google.com/drive/1g-U6M5VK60ZbpWAI7ovRwn9Qq3vRcMwp?usp=sharing)を開きます。
4. 画面左上の実行ボタンを押します。最初にwhisperのインストールが実行されるので、少し時間がかかります。
![](/images/dictation_by_whisper/01.png)
5. しばらくするとGoogle Driveへのアクセス許可を求める画面が出ますので、承認してください（承認しないと処理が進みません）。
6. 承認すると、文字起こしの処理が進みます。
7. 処理が完了すると画面の下の方に「文字起こし完了」というメッセージが表示されます。
8. 音声データを置いたフォルダと同じフォルダに音声データと同じファイル名で拡張子が".txt"のファイルができます。これが文字起こしの結果です。

## 最後に
このプログラムは、Pythonで書かれています。ここでは、誰でも簡単に使えるように（Pythonのインストールなどをしなくてもいいように）Google Colaboratoryで動かしていますが、無料版のGoogle Colaboratoryであれば、実行可能時間が短いので音声データの長さによってはすべてを処理できないかもしれません。

Pythonの環境を自分で動かせる方であれば、同じ処理をローカルで動かした方が良いとは思います。
