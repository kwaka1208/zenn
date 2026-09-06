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

この章で作るのはローカルリポジトリです。リモートは第9章で扱います。

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
New-Item README.md
```

どちらも「空のファイルを作る」コマンドです。macOS / Linux の `touch` にあたるものが、PowerShellでは `New-Item` になります。

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

macOSのテキストエディットや、Windowsのメモ帳で開いてもかまいません。拡張子が `.md` のままになっていることだけ確認してください。
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

ここがGitを理解する最初の関門です。Gitは、フォルダの中のファイルを次の4つの状態で見分けています。

| 状態 | 意味 |
|---|---|
| **Untracked**（未追跡） | Gitがまだ知らない、新しいファイル |
| **Modified**（変更済み） | Gitが知っているが、前回の記録から変わった |
| **Staged**（ステージ済み） | 次の記録に含めると決めたファイル |
| **Committed**（記録済み） | 履歴として保存が終わったファイル |

いま `README.md` は**Untracked**です。フォルダの中に置いただけでは、Gitは履歴に残してくれません。「このファイルも記録の対象にしてほしい」と明示的に伝える必要があります。

### なぜ自動で記録しないのか

「フォルダに入れたら全部記録すればいいのに」と思うかもしれません。しかし、プロジェクトの中には記録したくないファイルもあります。

- パスワードやAPIキーが書かれた設定ファイル
- ビルドで自動生成される大量のファイル
- 一時的に作った作業用のメモ

Gitが「記録するものを選ばせる」設計になっているのは、こうしたファイルを誤って公開しないためでもあります。記録したくないファイルの扱いは、第7章で詳しく扱います。

---

## 状態の流れをつかむ

これから使うコマンドと、状態の移り変わりを図にすると次のようになります。

```mermaid
flowchart LR
    W["作業ツリー<br/>編集する場所"] -- "git add" --> S["ステージ<br/>記録の準備台"]
    S -- "git commit" --> R["リポジトリ<br/>履歴の保管庫"]
```

- **作業ツリー**: いま実際にファイルを編集している場所
- **ステージ**（インデックスとも呼びます）: 「次の記録にはこれを含める」と選んだファイルを置く場所
- **リポジトリ**: `.git` の中。確定した履歴が積み上がる場所

`git add` でステージに載せ、`git commit` で履歴に確定する。この2ステップが、Gitの基本操作です。

:::message
「なぜ2ステップに分かれているの？」と思うかもしれません。これは、**変更の一部だけを選んで記録できるようにするため**です。5つのファイルを直したけれど、関係のある3つだけをひとまとまりとして記録したい、といったことができます。次の章で実際に体験します。
:::

---

## この章のまとめ

- `git init` でフォルダをリポジトリにする
- `.git` フォルダに履歴が入る。手で触らない
- `git status` で現在の状態を確認する
- ファイルを置いただけでは記録されない（Untracked）
- `git add` から `git commit` の2ステップで履歴になる

---

次の章では、実際に `git add` と `git commit` を実行して、最初の記録を残します。
