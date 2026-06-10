---
title: Google Colabでプログラミング学習者向けの教材を作る
emoji: "🐍"
type: idea
topics: [GoogleColab, AI, 初学者向け]
published: true
---

## この記事について

Google Colabでプログラミングの学習教材を公開している方向けに、学習者が使いやすい環境を整えるためのTIPSをまとめています。

## ノートブックをGitHubで管理する

Google ColabのノートブックはデフォルトでGoogle Drive内に保存されますが、GitHubで管理することで次のようなメリットがあります。

- バージョン管理や変更履歴の確認ができる
- ノートブックのURLが分かりやすくなる
- 教材の整理や資料への記載がしやすくなる

公開しても差し支えない内容であれば、GitHubでの管理をお勧めします。

`https://github.com/{account}/{repository}/` のリポジトリに `{file_name}.ipynb` を保存した場合、Google ColabからアクセスするURLは以下の形式になります。

```
https://colab.research.google.com/github/{account}/{repository}/blob/main/{file_name}.ipynb
```

リポジトリ内をディレクトリで分けた場合は、ファイル名の部分をフルパスにするだけです。

```
https://colab.research.google.com/github/{account}/{repository}/blob/main/{directory}/{file_name}.ipynb
```

参考として、私が公開しているノートブック（ワードクラウドを作るプログラム）のリンクを紹介します。

[https://colab.research.google.com/github/kwaka1208/ipynb/blob/main/tools/word_cloud.ipynb](https://colab.research.google.com/github/kwaka1208/ipynb/blob/main/tools/word_cloud.ipynb)

Google Driveで管理した場合のURLはランダムな文字列になるため、ファイルの内容をURLから判別できません。GitHubで管理することでリポジトリのパス構造がURLに反映されるので、複数の教材をまとめて扱う際に便利です。

## 生成AIアシストをオフにする

Google Colabには生成AIによるアシスト機能があり、ユーザーが指示しなくてもコードを自動補完・生成します。しかし学習用途では、学習者自身がコードを書く体験が大切なため、この機能はオフにしておくことをお勧めします。

この設定はノートブックごとに行えます。「編集」メニューの「ノートブックの設定」を選び、左側のメニューの「AIアシスタント」から「生成 AI 機能を非表示」にチェックを入れてください。

![](/images/google-colab-programming-for-learners/settings01.png)

ノートブックファイル（.ipynb）を直接編集して設定することもできます。

ソースコードをテキストファイルとして開き、`"metadata"` → `"colab"` のセクションを探して、以下の一行を追加します。

`"generative_ai_disabled": true`

追加後の記述は次のようになります。

```
 "metadata": {
  "colab": {
   "generative_ai_disabled": true,
```

GitHubでノートブックを管理している場合は、ファイルがPC上に存在するため一括で設定を書き換えられます。複数のノートブックに設定を適用する際はこちらの方法が効率的です。

なお、この設定は公式ドキュメントには記載がないようですが、以下のIssueで情報が確認できます。

https://github.com/googlecolab/colabtools/issues/4834

## 最後に

この記事がGoogle Colabで教材を公開している方の参考になれば幸いです。
