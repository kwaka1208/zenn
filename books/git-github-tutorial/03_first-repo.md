---
title: リポジトリを作る
---

この章では、Gitで管理するプロジェクト（リポジトリ）を作り、Gitがファイルをどう見ているかを理解します。

---

## リポジトリとは

**リポジトリ**とは、Gitが履歴を管理するプロジェクトのまとまりです。「このフォルダの中身を、Gitで管理してください」と指定したフォルダのことだと考えてください。

リポジトリには2種類あります。

- **ローカルリポジトリ**: 自分のパソコンの中にあるもの
- **リモートリポジトリ**: GitHubなど、インターネット上にあるもの

この章で作るのはローカルリポジトリです。リモートは第9章「GitHubに公開する（remote と push）」で扱います。

---

## プロジェクトフォルダを作る

前章で作った作業フォルダに移動して、メモ帳プロジェクトのフォルダを作ります。

```bash
cd ~/git-practice
mkdir my-notes
cd my-notes
```

これで、`~/git-practice/my-notes` の中にいる状態になりました。

---

## `git init` でリポジトリにする

いまのフォルダをGitの管理下に置きます。

```bash
git init
```

次のように表示されます。

```
Initialized empty Git repository in /Users/taro/git-practice/my-notes/.git/
```

Windowsでは、パスの部分が `C:/Users/taro/git-practice/my-notes/.git/` のように表示されます。

「空のGitリポジトリを初期化しました」という意味です。これで、このフォルダはリポジトリになりました。

### 何が起きたのか

フォルダの中を見てみましょう。隠しファイルも含めて表示するオプションを付けます。

macOS / Linux:

```bash
ls -a
```

```
.	..	.git
```

Windows（PowerShell 7）:

```powershell
ls -Force
```

```
    Directory: C:\Users\taro\git-practice\my-notes

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d--h-           2026/09/03    10:00                .git
```

:::message
隠しファイルを表示するオプションが、macOS / Linux では `-a`、PowerShellでは `-Force` です。名前は違いますが、役割は同じです。PowerShellの `ls` は表形式で表示され、`Mode` に `h`（hidden、隠し）が付いているものが隠しファイルです。
:::

どちらの環境でも、`.git` というフォルダができています。**この中にすべての履歴が保存されます。**

:::message alert
`.git` フォルダは手で編集したり削除したりしないでください。削除すると、そのリポジトリの履歴がすべて失われます。逆に言えば、「Gitの管理をやめたい」ときは `.git` フォルダを消せば、ただのフォルダに戻ります。
:::

中身をのぞいてみることはできます（見るだけなら安全です）。

```bash
ls .git
```

```
HEAD		config		description	hooks		info		objects		refs
```

Windowsでは表形式になります。Gitのバージョンによっては `branches` などが加わることもありますが、気にしなくて大丈夫です。

いまは意味がわからなくて大丈夫です。「履歴の実体はここにある」とだけ覚えておいてください。

---

## `git status` で状態を確認する

Gitでもっともよく使うコマンドが `git status` です。「いま何が起きているか」を教えてくれます。

```bash
git status
```

```
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

読み解くと、次のような意味です。

| 表示 | 意味 |
|---|---|
| `On branch main` | いま `main` というブランチにいる |
| `No commits yet` | まだ一度も記録していない |
| `nothing to commit` | 記録すべき変更がない（ファイルがないので当然） |

:::message
`git status` は何度実行しても何も壊しません。迷ったら実行する、を習慣にしてください。この本でも、操作のたびに実行して状態を確認していきます。
:::

---

## ファイルを作ってみる

では、最初のファイルを作りましょう。リポジトリの説明を書く `README.md` を作ります。

macOS / Linux:

```bash
touch README.md
```

Windows（PowerShell 7）:

```powershell
New-Item -ItemType File README.md
```

どちらも「空のファイルを作る」コマンドです。macOS / Linux の `touch` にあたるものが、PowerShellでは `New-Item -ItemType File` になります。

作ったファイルをエディタで開いて、中身を書きます。

```markdown:README.md
# わたしのメモ帳

日々のメモを Markdown で管理するリポジトリです。
```

:::details エディタの開き方がわからない方へ
Visual Studio Codeを使っている場合は、ターミナルで次のコマンドを実行するとフォルダごと開けます。

```bash
code .
```

`code` コマンドが使えない場合は、VS Codeを起動してから「ファイル」→「フォルダを開く」で `~/git-practice/my-notes` を選んでください。

macOSでは、できればVS Codeなどのプレーンテキストエディタを使ってください。テキストエディットを使う場合は、メニューの「フォーマット」→「標準テキストにする」を選んでから、拡張子を `.md` のまま保存します。Windowsのメモ帳は、そのまま使ってかまいません。
:::

---

## もう一度 `git status`

ファイルを作った状態で、もう一度確認してみましょう。

```bash
git status
```

```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	README.md

nothing added to commit but untracked files present (use "git add" to track)
```

さっきと表示が変わりました。`Untracked files`（追跡されていないファイル）という欄に `README.md` が出ています。

---

## Gitから見たファイルの状態

ここがGitを理解する最初の関門です。まず、ファイルがGitの**追跡対象かどうか**を分けて考えます。

| 区分 | 意味 |
|---|---|
| **Untracked**（未追跡） | Gitがまだ追跡していない、新しいファイル |
| **Tracked**（追跡中） | すでに一度 `git add` され、Gitが変更を追いかけているファイル |

いま `README.md` は**Untracked**です。フォルダの中に置いただけでは、Gitは履歴に残してくれません。「このファイルも記録の対象にしてほしい」と明示的に伝える必要があります。

### なぜ自動で記録しないのか

「フォルダに入れたら全部記録すればいいのに」と思うかもしれません。しかし、プロジェクトの中には記録したくないファイルもあります。

- パスワードやAPIキーが書かれた設定ファイル
- ビルドで自動生成される大量のファイル
- 一時的に作った作業用のメモ

Gitが「記録するものを選ばせる」設計になっているのは、こうしたファイルを誤って公開しないためでもあります。記録したくないファイルの扱いは、第7章「記録しないファイルを決める（.gitignore）」で詳しく扱います。

---

## 3つの領域をつかむ

追跡中のファイルの内容は、次の3つの領域を比べて捉えます。

```mermaid
flowchart LR
    W["作業ツリー<br/>手元で編集している内容"] -- "git add で内容を写す" --> I["インデックス（ステージ）<br/>次のコミット候補"]
    I -- "git commit で記録する" --> H["HEAD<br/>最新コミットの内容"]
```

- **作業ツリー**: いま実際にファイルを編集している場所
- **インデックス**（ステージとも呼びます）: 次のコミットに含める内容を準備する場所
- **HEAD**: 現在のブランチにある最新コミット。直前に記録した内容の基準

`git add` は、作業ツリーにある現在の内容をインデックスへ写します。`git commit` は、インデックスに用意した内容を新しいコミットとして記録し、HEADをそのコミットへ進めます。この2ステップがGitの基本操作です。

`Modified` は作業ツリーの内容がインデックスやHEADと異なること、`Staged` はインデックスの内容がHEADと異なり、次のコミット候補になっていることを表します。これらは排他的な状態ではありません。`git add` したあとで同じファイルをさらに編集すると、1つのファイルにステージ済みの変更と未ステージの変更が同時に存在します。

:::message
「なぜ2ステップに分かれているの？」と思うかもしれません。これは、**変更の一部だけを選んで記録できるようにするため**です。5つのファイルを直したけれど、関係のある3つだけをひとまとまりとして記録したい、といったことができます。次の章で実際に体験します。
:::

---

## この章のまとめ

- `git init` でフォルダをリポジトリにする
- `.git` フォルダに履歴が入る。手で触らない
- `git status` で現在の状態を確認する
- ファイルが追跡対象（Tracked）か未追跡（Untracked）かを区別する
- 作業ツリー・インデックス・HEADの3領域を比べて変更を捉える
- `git add` で内容をインデックスへ写し、`git commit` で履歴に記録する

---

次の章では、実際に `git add` と `git commit` を実行して、最初の記録を残します。
