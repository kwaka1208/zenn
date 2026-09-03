---
title: 記録しないファイルを決める（.gitignore）
---

プロジェクトの中には、Gitで管理したくないファイルがあります。この章では、それらを除外する `.gitignore` の使い方を学びます。

---

## なぜ除外が必要なのか

すべてのファイルをGitに入れると、次のような問題が起きます。

### 秘密の情報が公開されてしまう

APIキーやパスワードが書かれた設定ファイルをコミットして、そのままGitHubの公開リポジトリにpushすると、**世界中の誰でも読める状態**になります。これは実際によく起きる事故で、不正利用や高額請求につながることもあります。

### リポジトリが重くなる

`node_modules` のような、ツールが自動で作る大量のファイル。ビルド結果。動画や巨大な画像。これらを入れると、リポジトリが肥大化して、cloneやpushに時間がかかるようになります。

### 履歴が見づらくなる

エディタが勝手に作る設定ファイルや、macOSの `.DS_Store` などが混ざると、`git status` が本当に大事な変更を埋もれさせてしまいます。

---

## `.gitignore` を作る

除外したいファイルの名前を書いたファイルを、リポジトリの一番上に置きます。

macOS / Linux:

```bash
cd ~/git-practice/my-notes
touch .gitignore
```

Windows（PowerShell 7）:

```powershell
cd ~/git-practice/my-notes
New-Item .gitignore
```

中身を書きます。

```gitignore:.gitignore
# macOSが自動生成するファイル
.DS_Store

# エディタの設定
.vscode/
.idea/

# 一時ファイル
*.tmp
*.log

# 個人的な下書き（共有しない）
drafts/
```

:::message
`.gitignore` はドットで始まる隠しファイルです。エディタで見えないときは、隠しファイルを表示する設定に切り替えてください。VS Codeなら標準で表示されます。
:::

---

## 書き方のルール

| 書き方 | 意味 |
|---|---|
| `secret.txt` | この名前のファイルを除外 |
| `*.log` | 拡張子が `.log` のファイルをすべて除外 |
| `drafts/` | `drafts` フォルダの中身をまるごと除外 |
| `/config.json` | **一番上の階層の** `config.json` だけを除外 |
| `# コメント` | `#` で始まる行はコメント（無視される） |
| `!important.log` | 除外の対象から外す（例外指定） |

例外指定は、次のような組み合わせで使います。

```gitignore
# ログはすべて除外するが、サンプルだけは残す
*.log
!sample.log
```

---

## 動作を確かめる

実際に除外されるか試してみましょう。除外対象のファイルを作ります。

```bash
mkdir drafts
echo "これは下書きです" > drafts/idea.md
echo "エラーが出ました" > error.log
```

状態を確認します。

```bash
git status
```

```
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitignore

nothing added to commit but untracked files present (use "git add" to track)
```

`drafts/` も `error.log` も表示されません。Gitがきちんと無視してくれています。

`.gitignore` 自体はコミットします。**このファイルはチーム全員で共有すべき情報**だからです。

```bash
git add .gitignore
git commit -m "gitignoreを追加"
```

---

## 無視されているか確認する

「このファイルが無視されているのはなぜ？」と知りたいときは、次のコマンドが使えます。

```bash
git check-ignore -v drafts/idea.md
```

```
.gitignore:14:drafts/	drafts/idea.md
```

「`.gitignore` の14行目の `drafts/` という記述によって無視されています」という意味です。ルールが増えてくると重宝します。

無視されているファイルの一覧を見たいときは、次のように書きます。

```bash
git status --ignored
```

---

## すでにコミットしてしまった場合

ここが `.gitignore` の落とし穴です。

**`.gitignore` が効くのは、まだGitが知らないファイル（Untracked）に対してだけです。** 一度コミットしてしまったファイルは、あとから `.gitignore` に書いても無視されません。

その場合は、Gitの管理下から外す必要があります。

```bash
git rm --cached secret.txt
```

`--cached` は「**ファイルは残したまま**、Gitの管理からだけ外す」という指定です。これを付け忘れると、ファイル本体が削除されるので注意してください。

外したあとにコミットします。

```bash
git commit -m "secret.txtを管理対象から外す"
```

フォルダごと外したいときは、`-r`（再帰的）を付けます。

```bash
git rm -r --cached node_modules/
```

:::message alert
**すでにpushしてしまった秘密情報は、これだけでは安全になりません。**

`git rm --cached` でこれ以降の追跡は止まりますが、**過去のコミットの中には情報が残ったまま**です。誰でも履歴をさかのぼって読めます。

パスワードやAPIキーをpushしてしまった場合、まずやるべきことは**そのキーを無効化して再発行すること**です。履歴から完全に消す方法もありますが、手順が複雑で、共有済みの場合は全員に影響します。「漏れた鍵は捨てる」が鉄則です。
:::

---

## よく使う `.gitignore` の中身

言語や環境ごとに、定番の除外設定があります。参考として代表的なものを挙げます。

### 共通

```gitignore
.DS_Store
Thumbs.db
*.log
*.swp
.vscode/
.idea/
```

### Node.js / JavaScript

```gitignore
node_modules/
dist/
build/
.env
.env.local
npm-debug.log*
```

### Python

```gitignore
__pycache__/
*.pyc
.venv/
venv/
.env
```

`.env` は環境変数（データベースのパスワードやAPIキー）を書くファイルです。**どの言語でも、まず除外すべき筆頭**だと覚えておいてください。

:::message
GitHubが、言語・フレームワークごとの `.gitignore` テンプレートを公開しています。新しいプロジェクトを始めるときは、ここからコピーしてくるのが手軽で確実です。

https://github.com/github/gitignore
:::

---

## グローバルな `.gitignore`

`.DS_Store` や `.idea/` のような、**自分の環境が原因で出るファイル**は、プロジェクトごとに書くよりも、パソコン全体の設定にしたほうが合理的です。

```bash
git config --global core.excludesfile ~/.gitignore_global
```

そのうえで、ホームディレクトリに `.gitignore_global` を作ります。

```gitignore:~/.gitignore_global
.DS_Store
Thumbs.db
*.swp
.idea/
```

これで、すべてのリポジトリでこれらが無視されます。

:::message
プロジェクトの `.gitignore` にはチーム共通のルールを、グローバルには自分の環境固有のルールを書く。この使い分けを覚えておくと、チームの `.gitignore` を余計な記述で汚さずに済みます。
:::

---

## この章のまとめ

- 秘密情報・自動生成物・一時ファイルは `.gitignore` で除外する
- `.gitignore` 自体はコミットして共有する
- `.gitignore` は**まだコミットしていないファイル**にしか効かない
- コミット済みのものは `git rm --cached` で管理から外す
- pushしてしまった秘密鍵は、消すより先に**無効化して作り直す**
- 自分の環境固有のものはグローバル設定へ

---

ここまでで、ひとりでGitを使うための基本は身につきました。次の章からは、GitHubを使って外に出していきます。
