---
title: 履歴を見る（log と diff）
---

コミットを積み上げてきました。この章では、その履歴を見返す方法を学びます。「いつ、誰が、何を変えたのか」を調べられるのが、バージョン管理の大きな価値です。

---

## `git log` で履歴を見る

まずは基本の形です。

```bash
git log
```

```
commit 7f3a9c2e1b8d4a5f6c7e8d9a0b1c2d3e4f5a6b7c (HEAD -> main)
Author: Taro Yamada <taro@example.com>
Date:   Wed Sep 3 11:20:15 2025 +0900

    todoに項目を追加

commit 4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e
Author: Taro Yamada <taro@example.com>
Date:   Wed Sep 3 11:15:42 2025 +0900

    メモ用のnotesフォルダを追加

commit a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0
Author: Taro Yamada <taro@example.com>
Date:   Wed Sep 3 11:10:03 2025 +0900

    初回コミット: READMEを追加
```

新しいコミットが上に、古いものが下に表示されます。各コミットには次の情報が付いています。

| 項目 | 意味 |
|---|---|
| `commit` の後の文字列 | コミットID（ハッシュ） |
| `HEAD -> main` | いま自分がここにいるという印 |
| `Author` | 誰がコミットしたか（第2章で設定した情報） |
| `Date` | いつコミットしたか |
| インデントされた行 | コミットメッセージ |

:::message
履歴が長くなると、画面に収まらず表示が止まります。これは `less` というページャの画面です。

- `スペースキー` または `f`: 次のページへ
- `b`: 前のページへ
- `q`: 終了して元のプロンプトに戻る

抜けられなくなったら、`q` を押してください。
:::

---

## 見やすく表示する

`git log` はそのままだと情報量が多すぎます。よく使うオプションを紹介します。

### 1行ずつ表示する

```bash
git log --oneline
```

```
7f3a9c2 (HEAD -> main) todoに項目を追加
4d5e6f7 メモ用のnotesフォルダを追加
a1b2c3d 初回コミット: READMEを追加
```

とてもすっきりしました。日常的にはこの形をいちばんよく使います。

### 件数を絞る

```bash
git log --oneline -5
```

直近5件だけを表示します。

### 変更されたファイルも見る

```bash
git log --stat
```

```
commit 7f3a9c2e1b8d4a5f6c7e8d9a0b1c2d3e4f5a6b7c (HEAD -> main)
Author: Taro Yamada <taro@example.com>
Date:   Wed Sep 3 11:20:15 2025 +0900

    todoに項目を追加

 notes/todo.md | 1 +
 1 file changed, 1 insertion(+)
```

どのファイルが何行変わったのかがわかります。

### 枝分かれの様子を図で見る

```bash
git log --oneline --graph --all
```

いまは一本道なので効果がわかりませんが、第11章でブランチを使い始めると威力を発揮します。

### 特定のファイルの履歴だけ見る

```bash
git log --oneline notes/todo.md
```

「このファイルはいつ、どう変わってきたのか」を追いかけられます。

---

## エイリアスで短くする

毎回長いオプションを打つのは面倒です。Gitには、コマンドに別名を付ける**エイリアス**という機能があります。

```bash
git config --global alias.lg "log --oneline --graph --all --decorate"
```

これ以降は、次のように短く書けます。

```bash
git lg
```

よく使うものをいくつか登録しておくと快適になります。

```bash
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.br "branch"
```

---

## `git diff` で変更内容を見る

`git log` は「どんなコミットがあるか」を見るものでした。「具体的にどの行が変わったのか」を見るのが `git diff` です。

まず、ファイルを編集してみます。

```markdown:notes/books.md
# 読みたい本

- 銀河鉄道の夜
- 吾輩は猫である
- こころ
```

この状態で実行します。

```bash
git diff
```

```diff
diff --git a/notes/books.md b/notes/books.md
index 1a2b3c4..5d6e7f8 100644
--- a/notes/books.md
+++ b/notes/books.md
@@ -2,3 +2,4 @@
 
 - 銀河鉄道の夜
 - 吾輩は猫である
+- こころ
```

### 差分の読み方

見慣れない記号が並んでいますが、注目すべきは最後の数行だけです。

| 記号 | 意味 |
|---|---|
| `+` で始まる行 | 追加された行 |
| `-` で始まる行 | 削除された行 |
| 記号なしの行 | 変わっていない行（前後の目印として表示される） |

上の例では「`- こころ` という行が1行追加された」ことがわかります。

`@@ -2,3 +2,4 @@` の部分は「変更前は2行目から3行分、変更後は2行目から4行分」という位置情報です。慣れるまでは読み飛ばして構いません。

---

## ステージとの関係で使い分ける

`git diff` は、何と何を比べるかで書き方が変わります。ここは混乱しやすいところなので、表で整理します。

| コマンド | 比べる対象 |
|---|---|
| `git diff` | 作業ツリー ↔ ステージ（まだ `add` していない変更） |
| `git diff --staged` | ステージ ↔ 最新のコミット（`add` 済みの変更） |
| `git diff HEAD` | 作業ツリー ↔ 最新のコミット（両方あわせた全変更） |

実際に試してみましょう。

```bash
git add notes/books.md
git diff
```

何も表示されません。`add` したことで、作業ツリーとステージの内容が同じになったからです。

```bash
git diff --staged
```

今度はさっきと同じ差分が表示されます。ステージに載った変更を、コミット前に確認できるわけです。

:::message
コミットする直前に `git diff --staged` を実行して、「これから記録される内容」を確認する習慣をつけると、うっかりミスが激減します。
:::

確認できたらコミットします。

```bash
git commit -m "読みたい本に「こころ」を追加"
```

---

## `git show` で1つのコミットを詳しく見る

特定のコミットの中身を見たいときは `git show` を使います。

```bash
git show
```

引数なしだと、最新のコミットの内容と差分が表示されます。

過去のコミットを見たいときは、コミットIDを指定します。

```bash
git show a1b2c3d
```

IDは `git log --oneline` で調べた先頭7文字で構いません。

:::message
`HEAD` は「いま自分がいるコミット」を指す特別な名前です。`HEAD~1` は1つ前、`HEAD~2` は2つ前を意味します。

```bash
git show HEAD~1
```

このように書くと、IDを調べなくても過去のコミットを見られます。
:::

---

## 誰がその行を書いたか調べる

「この行はいつ、誰が、なぜ書いたのか」を調べたいときは `git blame` を使います。

```bash
git blame notes/todo.md
```

```
4d5e6f7a (Taro Yamada 2025-09-03 11:15:42 +0900 1) # やること
4d5e6f7a (Taro Yamada 2025-09-03 11:15:42 +0900 2) 
4d5e6f7a (Taro Yamada 2025-09-03 11:15:42 +0900 3) - [ ] 牛乳を買う
4d5e6f7a (Taro Yamada 2025-09-03 11:15:42 +0900 4) - [ ] 図書館に本を返す
7f3a9c2e (Taro Yamada 2025-09-03 11:20:15 +0900 5) - [ ] Gitの練習をする
```

行ごとに「どのコミットで書かれたか」がわかります。表示されたコミットIDを `git show` で調べれば、そのときの意図（コミットメッセージ）も読めます。

:::message
blameは「非難する」という意味の単語ですが、犯人捜しのための機能ではありません。「この不思議なコードには何か理由があるはずだ」と調べるときに使う、とても実用的なコマンドです。
:::

---

## この章のまとめ

- `git log --oneline` が日常の基本形
- `git diff` は「まだaddしていない変更」、`git diff --staged` は「addした変更」
- コミット前に `git diff --staged` で確認する習慣をつける
- `git show` で特定のコミットの中身を見る
- `HEAD` は現在地、`HEAD~1` は1つ前
- `git blame` で行ごとの由来をたどれる

---

次の章では、「やっぱり取り消したい」ときの方法を学びます。
