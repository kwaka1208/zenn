---
title: サイトにGitHubのAvatar(Profile picture)を埋め込む
emoji: "😃"
type: idea
topics: [GitHub, Avatar]
published: true
---

サイトにGitHubのアバター画像を埋め込む方法です。

## GitHubのAvatar取得方法
GitHubのAvatarは、以下のURLで取得可能です。
```
https://avatars.githubusercontent.com/{username}
```
この{username}の部分を自分のユーザー名に変えればOK。私の場合は、"kwaka1208"なので、以下のURLになります。
```
https://avatars.githubusercontent.com/kwaka1208
```
これを表示させるとこのようになります。
![GitHubのAvatar](https://avatars.githubusercontent.com/kwaka1208)

このタグをサイトにに記述すればAvatarが表示されます。

## Avatar画像を丸くする。
ついでに、このAvatar画像を丸くする方法も書いておきます。
CSSで画像の大きさを指定し、一辺の長さ（正方形なので縦横どちらでもOK）にの半分を半径とした"border-radius"を指定すれば画像が丸く切り取られます。

例えば、Avatarの大きさを縦横それぞれ128pxにした場合、border-radiusの値は64pxを指定します。
```
<img src="https://avatars.githubusercontent.com/{username}" style="border-radius: 64px; width: 128px;">
```

実際にこの方法で埋め込まれた状態を見せられればよいのですが、zennには直接HTMLが書けないので、ご自身でお試しください。

以上です(`・ω・́)ゝ
