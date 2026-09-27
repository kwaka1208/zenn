---
title: 変更を記録する（add と commit）
---

この章では、Gitの中心となる操作、**コミット**を行います。ここが使えるようになれば、Gitの基本の半分は身についたと言えます。

---

## `git add` でステージに載せる

前章で作った `README.md` を、記録の対象にします。

```bash
git add README.md
```

実行しても何も表示されませんが、それで正常です。Gitは「うまくいったときは黙っている」ことが多いツールです。

状態を確認しましょう。

```bash
git status
```

```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   README.md
```

`Untracked files` だった `README.md` が、`Changes to be committed`（コミットされる予定の変更）に移りました。**ステージに載った**状態です。

---

## `git commit` で記録する

いよいよ履歴に記録します。

```bash
git commit -m "初回コミット: READMEを追加"
```

```
[main (root-commit) a1b2c3d] 初回コミット: READMEを追加
 1 file changed, 3 insertions(+)
 create mode 100644 README.md
```

これで最初のコミットが完成しました。表示の意味は次のとおりです。

| 表示 | 意味 |
|---|---|
| `main` | `main` ブランチにコミットした |
| `root-commit` | このリポジトリの最初のコミット |
| `a1b2c3d` | このコミットのID（後述） |
| `1 file changed, 3 insertions(+)` | 1ファイルが変わり、3行追加された |

### `-m` オプションとは

`-m` は **message**（メッセージ）の略で、そのコミットの説明を付けるためのものです。「何をしたのか」を後から見返すための、大事なメモになります。

`-m` を付けずに `git commit` だけを実行すると、エディタが立ち上がってメッセージの入力を求められます。慣れないうちは `-m` を使うのが安全です。

:::details エディタが開いてしまって抜けられないとき
Gitの標準エディタはvimであることが多く、はじめて開くと「どうやって終わるのか」がわかりません。次の手順で抜けられます。

1. `Esc` キーを押す
2. `:q!` と入力する（コロンも含めて入力します）
3. `Enter` を押す

これでコミットは中止されます。エディタをVS Codeなどに変えたい場合は、次のように設定します。

```bash
git config --global core.editor "code --wait"
```
:::

---

## コミットIDとは

コミットには、`a1b2c3d4e5f6...` のような40文字の英数字のIDが自動で付きます。これを**コミットハッシュ**と呼びます。

長いので、普段は先頭の7文字程度だけを使います。この本でも `a1b2c3d` のように短縮形で表記します。

このIDは「どのコミットのことを言っているのか」を指定するときに使います。第6章「やり直す（restore・amend・reset・revert）」などで登場します。

---

## 状態を確認する

コミット後に、もう一度確認しましょう。

```bash
git status
```

```
On branch main
nothing to commit, working tree clean
```

`working tree clean`（作業ツリーはきれい）と出ました。これは「記録していない変更がひとつもない」という意味です。Gitを使ううえで、いちばん安心できる状態です。

---

## ファイルを増やしてコミットする

次に、メモを入れるフォルダを作ります。

```bash
mkdir notes
```

その中に、やることリストを作ります。

```markdown:notes/todo.md
# やること

- [ ] 牛乳を買う
- [ ] 図書館に本を返す
```

読みたい本のリストも作りましょう。

```markdown:notes/books.md
# 読みたい本

- 銀河鉄道の夜
- 吾輩は猫である
```

状態を見てみます。

```bash
git status
```

```
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	notes/

nothing added to commit but untracked files present (use "git add" to track)
```

`notes/` とフォルダ名だけが表示されています。Gitは中身のファイルをまだ何も知らないので、まとめて「このフォルダが未追跡です」と伝えているのです。

:::message
Gitが管理するのは**ファイル**であって、フォルダではありません。そのため、中身が空のフォルダはGitに記録できません。空フォルダを残したいときは、慣習として `.gitkeep` という空ファイルを置きます。
:::

---

## まとめて `git add` する

ファイルを1つずつ指定してもよいのですが、まとめて追加する書き方もあります。

```bash
git add notes/
```

フォルダを指定すると、その中のファイルがまとめてステージに載ります。

```bash
git status
```

```
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   notes/books.md
	new file:   notes/todo.md
```

2つのファイルが載りました。コミットします。

```bash
git commit -m "メモ用のnotesフォルダを追加"
```

---

## `git add` の書き方いろいろ

| 書き方 | 意味 |
|---|---|
| `git add ファイル名` | 指定したファイルだけを載せる |
| `git add フォルダ名/` | フォルダの中身をまとめて載せる |
| `git add .` | いまいる場所から下のすべての変更を載せる |
| `git add -A` | リポジトリ全体のすべての変更を載せる |
| `git add -u` | すでに管理下にあるファイルの変更だけを載せる |

`git add .` はとても便利で、実際の開発でも多用されます。ただし便利さの裏返しで、**意図しないファイルまで載せてしまう危険**があります。

:::message alert
`git add .` を使うときは、実行前に必ず `git status` で「何が載ろうとしているか」を確認してください。パスワードの書かれたファイルや、巨大な一時ファイルを誤ってコミットする事故は、この一手間で防げます。
:::

---

## ファイルを編集してコミットする

新規追加だけでなく、既存ファイルを編集した場合も見ておきましょう。`notes/todo.md` に1行足します。

```markdown:notes/todo.md
# やること

- [ ] 牛乳を買う
- [ ] 図書館に本を返す
- [ ] Gitの練習をする
```

状態を確認します。

```bash
git status
```

```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   notes/todo.md

no changes added to commit (use "git add" and/or "git commit -a")
```

今回は `Untracked` ではなく `modified`（変更済み）と表示されました。Gitがすでに知っているファイルなので、「前回の記録から変わっています」と教えてくれているわけです。

ステージに載せてコミットします。

```bash
git add notes/todo.md
git commit -m "todoに項目を追加"
```

:::message
すでに管理下にあるファイルの変更だけなら、`git commit -am "メッセージ"` と書くと `add` と `commit` を一度に実行できます。ただし新規ファイル（Untracked）は対象外なので、`git add` が必要です。
:::

---

## よいコミットメッセージを書く

コミットメッセージは、未来の自分やチームメンバーへの手紙です。数か月後に履歴を見返したとき、意味がわかるように書きましょう。

### 避けたい書き方

```
修正
update
aaa
いろいろ変更
```

これでは、あとで見ても何をしたのかわかりません。

### おすすめの書き方

```
ログイン画面のパスワード入力欄の表示崩れを修正
READMEにインストール手順を追加
使われていない古い設定ファイルを削除
```

ポイントは3つです。

1. **何をしたのかを具体的に書く**
2. **1行目は50文字程度までに収める**（一覧で見たときに読みやすい）
3. **「なぜ」を補足したいときは、空行をあけて2行目以降に書く**

複数行のメッセージは、`-m` を2回使うと書けます。

```bash
git commit -m "設定ファイルの読み込み先を変更" -m "本番環境とテスト環境で別ファイルを使いたいため"
```

---

## コミットの粒度

「どのくらいの変更でコミットすればいいのか」も、よくある悩みです。目安は次のとおりです。

- **ひとつのコミットに、ひとつの意味を持たせる**
- 「〇〇を修正して、ついでに△△も追加した」となったら、分けたほうがよい
- 自分だけが使う作業ブランチでは、あとで整理する前提で、動作しない途中の状態を一時的にコミットしてもよい

細かすぎるコミットは後からまとめられますが、大きすぎるコミットは分けるのが大変です。迷ったら細かめに刻んでおくのがおすすめです。ただし、共有するブランチや `main` には、ビルドやテストが通らない途中のコミットをそのまま送らないようにしましょう。

---

## この章のまとめ

- `git add` でステージに載せ、`git commit -m "..."` で記録する
- `git status` は `Untracked` / `modified` / `Changes to be committed` を見分けて教えてくれる
- `git add .` は便利だが、実行前に `git status` で確認する
- コミットメッセージは「何をしたか」が伝わるように書く
- ひとつのコミットにはひとつの意味を

---

次の章では、積み上げた履歴を見返す方法を学びます。
