---
title: ブランチを使う
---

ここまでは、一本道の履歴を積み上げてきました。この章では、履歴を枝分かれさせる**ブランチ**を学びます。Gitがこれほど広く使われている理由の中心にある機能です。

---

## ブランチとは

**ブランチ**（branch = 枝）は、履歴を枝分かれさせて、複数の作業を並行して進めるための仕組みです。

たとえば、こんな状況を考えてください。

- いま公開しているメモは、いつでも人に見せられる状態にしておきたい
- でも、大きな構成変更を試したい
- 試している途中の中途半端な状態は、公開したくない

ブランチを使えば、本流（`main`）はそのままに、別の枝で自由に実験できます。うまくいったら本流に合流させ、失敗したら枝ごと捨てればよいのです。

```
main:     A --- B --- C
                 \
実験用の枝:        D --- E
```

---

## いまのブランチを確認する

```bash
cd ~/git-practice/my-notes
git branch
```

```
* main
```

`*` が付いているのが、いま自分がいるブランチです。まだ `main` しかありません。

`git status` の1行目でも確認できます。

```bash
git status
```

```
On branch main
nothing to commit, working tree clean
```

:::message alert
ブランチを作る前に、`nothing to commit, working tree clean` になっているか確認してください。作業中の変更があると、それを持ったまま別のブランチに移動してしまい、混乱の原因になります。
:::

---

## ブランチを作って移動する

メモの分類機能を追加する、という想定で新しいブランチを作ります。

```bash
git switch -c add-categories
```

```
Switched to a new branch 'add-categories'
```

`-c` は **create**（作成）の略です。「ブランチを作って、そこに移動する」を一度に行います。

確認しましょう。

```bash
git branch
```

```
  add-categories
* main
```

`*` が `add-categories` に移っています。

:::message
Gitのバージョンによっては、`git checkout -b add-categories` という書き方も使われます。こちらは古くからあるコマンドで、いまでも動きます。

ただし `checkout` は「ブランチ移動」と「ファイルの復元」という異なる役割を1つのコマンドが担っていて、初心者が混乱しやすい原因になっていました。そこでGit 2.23から、役割ごとに `switch`（ブランチ操作）と `restore`（ファイル復元）に分けられました。これから覚えるなら `switch` と `restore` をおすすめします。
:::

### ブランチ名の付け方

チームによってルールはさまざまですが、よく使われるのは次のような形式です。

```
feature/カテゴリ機能を追加
fix/ログイン時のエラーを修正
docs/READMEを更新
```

`/` で用途を分け、内容がわかる名前にします。日本語も使えますが、環境によって問題が起きることがあるため、英数字とハイフンにしておくのが無難です。

---

## ブランチで作業する

新しいブランチで、実際にファイルを変更します。

```markdown:notes/todo.md
# やること

## 買い物

- [x] 牛乳を買う

## 勉強

- [ ] Gitの練習をする
- [ ] GitHubにpushしてみる

## その他

- [ ] 図書館に本を返す
```

コミットします。

```bash
git add notes/todo.md
git commit -m "todoをカテゴリ別に整理"
```

もう1つ変更を加えましょう。

```markdown:notes/books.md
# 読みたい本

## 小説

- 銀河鉄道の夜
- 吾輩は猫である
- こころ
- 人間失格

## 技術書

- リーダブルコード
```

```bash
git add notes/books.md
git commit -m "読みたい本をジャンル別に整理"
```

---

## ブランチを行き来する

ここで `main` に戻ってみましょう。

```bash
git switch main
```

```
Switched to branch 'main'
```

ファイルの中身を見てください。

```bash
cat notes/todo.md
```

カテゴリ分けする前の状態に戻っています。**ブランチを切り替えると、作業フォルダの中身がそのブランチの状態に置き換わる**のです。

もう一度、作業ブランチに戻ります。

```bash
git switch add-categories
cat notes/todo.md
```

カテゴリ分けした内容が戻ってきました。

:::message
ファイルが消えたり復活したりするので驚くかもしれませんが、どちらの状態も `.git` の中に安全に保管されています。切り替えるたびに、必要なほうが取り出されているだけです。

なお、直前にいたブランチには `-` で戻れます。

```bash
git switch -
```
:::

---

## ブランチの様子を図で見る

第5章で紹介したコマンドが、ここで役に立ちます。

```bash
git log --oneline --graph --all
```

```
* 3c4d5e6 (HEAD -> add-categories) 読みたい本をジャンル別に整理
* 2b3c4d5 todoをカテゴリ別に整理
* 9b8c7d6 (origin/main, main) 読みたい本に「人間失格」を追加
* 7f3a9c2 todoの進捗を更新
```

`main` は `9b8c7d6` で止まっていて、そこから `add-categories` が2つ先に進んでいることが読み取れます。

---

## ブランチをGitHubにpushする

作業ブランチも、GitHubに送れます。

```bash
git push -u origin add-categories
```

```
remote: Create a pull request for 'add-categories' on GitHub by visiting:
remote:      https://github.com/taro/my-notes/pull/new/add-categories
To github.com:taro/my-notes.git
 * [new branch]      add-categories -> add-categories
```

GitHubのリポジトリページを開くと、上部に「add-categories had recent pushes」という黄色い帯が表示されているはずです。これは第13章で使うので、いまは押さずに置いておきます。

:::message
新しいブランチの初回pushでは `-u origin ブランチ名` が必要です。第9章と同じで、2回目以降は `git push` だけで済みます。
:::

---

## ブランチを削除する

不要になったブランチは削除します。まず、削除するブランチ以外に移動しておきます。

```bash
git switch main
git branch -d 削除したいブランチ名
```

`-d` は「合流済みのブランチだけ削除する」という安全なオプションです。まだ合流していないブランチを削除しようとすると、警告が出て止まります。

```
error: the branch 'add-categories' is not fully merged.
```

これは「このブランチの変更はまだどこにも取り込まれていません。消すと失われますよ」という親切な警告です。

どうしても削除したいときは `-D`（大文字）を使います。

```bash
git branch -D 削除したいブランチ名
```

:::message alert
`-D` で削除した内容は、`git log` からは辿れなくなります。ただし第6章で紹介した `git reflog` には残っているので、直後であれば復旧できる可能性があります。
:::

なお、`add-categories` はこのあと第12章と第13章で使うので、まだ削除しないでください。

---

## ブランチの実体はとても軽い

ここまでの説明で「ブランチを作るとファイルが複製されるのでは」と思ったかもしれませんが、そうではありません。

Gitのブランチの実体は、**「どのコミットを指しているか」を記録した41バイト程度のファイル**です。だから、いくつ作っても容量をほとんど使いませんし、作成も切り替えも一瞬で終わります。

この軽さのおかげで、実際の開発では次のような使い方が当たり前になっています。

- 小さな修正でも、そのつどブランチを切る
- 試したいことがあれば、気軽にブランチを作って実験する
- ダメだったらブランチごと捨てる

「ブランチを作るのはおおごと」と身構える必要はありません。

---

## この章のまとめ

- ブランチは履歴を枝分かれさせ、並行作業を可能にする
- `git switch -c 名前` で作成して移動、`git switch 名前` で移動
- ブランチを切り替えると、作業フォルダの中身が入れ替わる
- `git branch` で一覧、`git log --oneline --graph --all` で全体像
- `git push -u origin ブランチ名` でリモートにも送れる
- `git branch -d` で削除（安全）、`-D` で強制削除
- ブランチは軽いので、気軽に作ってよい

---

次の章では、枝分かれした変更を合流させます。
