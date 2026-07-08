---
title: microbit用パッケージの言語リソースの命名ルール
emoji: "✉"
type: tech
topics: [microbit]
published: false
---

micro:bit用のプログラミング環境である[ブロックエディタ(MakeCode)](https://makecode.microbit.org/)では、自作のブロックを追加できる機能があるのですが、パッケージを複数の言語に対応（ローカライズ）するためのルールで、公式のドキュメントに書かれていないことを補足する記事です。

公式のドキュメントの方にもPRを送るつもりですが、英語なのでとりあえずこちらに日本語でメモとして。

## micro:bit用拡張パッケージの開発方法
micro:bit用拡張パッケージの開発方法については、[公式のドキュメント](https://makecode.com/packages)がありますのでそちらをご覧ください。ただ、なにかと情報不足な点は否めません...。

## ローカライズ用言語リソースの置き方
このドキュメントの中に[言語対応（localization）](https://makecode.com/packages/localization)の説明があり（元々無かったけれど質問したら追加されたようだ）、基本的にはここに書いてある通りなのですが、言語リソースファイル名の命名ルールの説明がありません。

言語リソースファイルは以下のルールに従ってください。
1. "_locales"ディレクトリを作成する。
2. その下に各言語ごとのディレクトリを作成する。ディレクトリ名には[ISO 3166-1 alpha-2](https://ja.wikipedia.org/wiki/ISO_3166-1)を小文字で使用します。日本の場合は"ja"となります。
3. 各言語のディレクトリの中に「{pxt.jsonの"name"で指定した名前}-strings.json」のファイル名で言語リソースファイルを置きます。

```
"ExternalPackages"の日本語リソースの場合。
"_locales/ja/ExternalPackages-strings.json"
```

ツールチップの言語リソースの場合は、「{pxt.jsonの"name"で指定した名前}-jsdoc-strings.json」となります。

## 言語リソースの書き方
言語リソースの書き方については、実際にパッケージを開発されている方なら、公開されているパッケージを参考にすればわかると思いますので、省略します。

- [neopixelのパッケージ](https://github.com/Microsoft/pxt-neopixel)

## 最後に
めっちゃ走り書きで申し訳ありませんが、もし困っている方の参考になればと思い取り急ぎシェアしました。
