---
title: よくあるトラブルとコマンド早見表
---

この章は、困ったときに開く辞書として使ってください。実際によく遭遇する場面を、症状別にまとめます。

---

## 困ったときの第一手

何が起きているかわからなくなったら、まず次の3つを実行してください。**この3つで、状況の8割は把握できます。**

```bash
git status
git log --oneline --graph --all -10
git branch -a
```

それぞれ「いまの状態」「履歴の形」「ブランチの一覧」を教えてくれます。どれも何も壊しません。

---

## コミットに関するトラブル

### コミットしようとしたらエラーになる

```
*** Please tell me who you are.
```

名前とメールアドレスが未設定です。第2章「Gitの準備と初期設定」の設定を行ってください。

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### コミットメッセージを間違えた

まだpushしていなければ、書き直せます。

```bash
git commit --amend -m "正しいメッセージ"
```

pushしてしまった場合は、無理に直さないほうが安全です。どうしても直したいときは、チームに影響がないか確認してから行ってください。

### ファイルを1つ入れ忘れた

```bash
git add 忘れたファイル
git commit --amend --no-edit
```

### 巨大なファイルをコミットしてpushできない

```
remote: error: File big-video.mp4 is 150.00 MB; this exceeds GitHub's file size limit of 100.00 MB
```

GitHubには100MBの上限があります。直前のコミットなら、次の手順で取り除けます。

```bash
git reset --soft HEAD~1
git rm --cached big-video.mp4
echo "big-video.mp4" >> .gitignore
git add .gitignore
git commit -m "大きなファイルを除外"
```

:::message
すでに何度もコミットを重ねている場合、履歴の奥から大きなファイルを取り除くのは手間がかかります。動画や大きな画像は、最初から `.gitignore` に入れておくのが最善です。

どうしてもGitで大きなファイルを扱いたい場合は、Git LFSという仕組みがあります。
:::

---

## pushに関するトラブル

### pushが拒否される

```
! [rejected]        main -> main (fetch first)
```

リモートに、自分がまだ持っていない変更があります。すぐに合流せず、まず取得して履歴の差を確認します。

```bash
git fetch origin
git log --oneline --graph --left-right HEAD...origin/main
```

内容を確認できたら、本書で使ってきたmerge方式で取り込み、pushします。

```bash
git merge origin/main
git push
```

`git merge` でコンフリクトが起きたら、第12章「合流させる（mergeとコンフリクト）」の手順で解決してください。

### `Permission denied (publickey)`

SSH鍵の設定に問題があります。まず接続を確認します。

```bash
ssh -T git@github.com
```

失敗する場合、次を順に確認してください。

1. 鍵がssh-agentに登録されているか

```bash
ssh-add -l
```

「The agent has no identities.」なら登録します。

```bash
ssh-add ~/.ssh/id_ed25519
```

2. GitHubに登録したのが**公開鍵**（`.pub` のほう）か
3. 貼り付けた内容が途中で切れていないか

### `Repository not found`

次のいずれかです。

- URLのユーザー名やリポジトリ名が間違っている
- Privateリポジトリにアクセス権がない
- 認証に失敗している（別アカウントの鍵を使っている）

URLを確認します。

```bash
git remote -v
```

間違っていれば修正します。

```bash
git remote set-url origin git@github.com:正しいユーザー名/正しいリポジトリ名.git
```

---

## ブランチに関するトラブル

### ブランチを切り替えられない

```
error: Your local changes to the following files would be overwritten by checkout
```

作業中の変更が失われるため、Gitが止めています。3つの対処法があります。

```bash
# 1. コミットする
git add . && git commit -m "作業途中"

# 2. 未追跡ファイルも含めて一時的に退避する
git stash push -u -m "作業退避"

# 3. 変更を捨てる（戻せません）
git restore .
```

既定の `git stash` は未追跡ファイルを含みません。新しく作ったファイルも持ち運ぶときは、`-u` を付けます。退避した変更は、移動先の状態を確認してから戻します。

```bash
git status
git stash pop
git status
```

`git stash pop` でもコンフリクトが起きることがあります。その場合は、ファイルを修正してから `git add` し、解消します。

### 間違ったブランチで作業してしまった

まだコミットしていない場合、未追跡ファイルも含めて `stash` で持ち運べます。

```bash
git stash push -u -m "作業退避"
git switch 正しいブランチ
git status
git stash pop
git status
```

`git stash pop` でコンフリクトが起きた場合は、内容を確認して解消してください。

コミットまでしてしまった場合は、まず状態とコミットIDを確認します。

```bash
git status
git log --oneline -3
```

作業ツリーがcleanであることを確認したら、正しいブランチにコミットを取り込みます。不安なら、先に `git branch rescue-before-move コミットID` として退避用ブランチを作ってください。

```bash
git switch 正しいブランチ
git cherry-pick コミットID
```

`git cherry-pick` は「特定のコミットだけを、いまのブランチに取り込む」コマンドです。

元のブランチが**まだpushされておらず**、移したコミットが**直前の1コミット**で、作業ツリーが**clean**な場合に限り、元のブランチを巻き戻せます。

```bash
git switch 間違えたブランチ
git status
git reset --hard HEAD~1
```

すでにpushして共有したコミットは、履歴を書き換えず、打ち消すコミットを作ります。

```bash
git switch 間違えたブランチ
git revert コミットID
git push
```

### 過去に戻ったまま迷子になった

```
You are in 'detached HEAD' state.
```

`git switch --detach コミットID` などで、ブランチから離れた状態です。

```bash
git switch main
```

これで戻れます。detached HEADの状態でコミットしてしまった場合は、先にそのコミットを保存しておきます。

```bash
git switch -c 救出用ブランチ名
```

---

## 変更が消えたと思ったとき

### 直前の操作を取り消したい

```bash
git reflog
```

`HEAD` が移動したすべての記録が出ます。戻りたいコミットIDを見つけたら、まずその地点を指す救出用ブランチを作ります。

```bash
git branch rescue 戻りたいコミットID
git log --oneline rescue -3
```

内容を確認し、その地点から作業を続けるなら切り替えます。

```bash
git switch rescue
```

元のブランチ自体をその地点へ戻す `git reset --hard` は、現在の変更が不要または退避済みで、対象ブランチと戻り先を確認できた場合だけの最終手段です。

**`reset --hard` の直後、`--amend` の直後、ブランチ削除の直後**なら、たいてい `reflog` からコミットを救出できます。

### `git restore` で消してしまった変更

残念ながら、これは戻せません。コミットしていない変更はGitがどこにも記録していないためです。

エディタによっては、ローカルの編集履歴から復元できることがあります。VS Codeなら、ファイルを右クリックして「タイムライン」を確認してみてください。

---

## その他のトラブル

### 日本語のファイル名が文字化けする

```bash
git config --global core.quotepath false
```

### 改行コードの警告が出る

```
warning: LF will be replaced by CRLF in notes/todo.md.
The file will have its original line endings in your working directory
```

WindowsとmacOS/Linuxで改行コードの扱いが違うことによる警告です。まず、プロジェクトの `.gitattributes` とチームの方針を確認してください。たとえば、チームでLFに統一すると合意した場合は、次のファイルをリポジトリに置いてコミットします。

```:.gitattributes
* text=auto eol=lf
```

`.gitattributes` はそのリポジトリを使う全員に共有されるため、チームの方針を揃えるのに向いています。

`core.autocrlf` のグローバル設定は、ほかのリポジトリにも影響します。既存プロジェクトでは一律に変更せず、`.gitattributes` がない場合もチームや教材の指定を確認してから設定してください。

### エディタから抜けられない

vimが開いている場合です。

- 保存して終了: `Esc` → `:wq` → Enter
- 保存せず終了: `Esc` → `:q!` → Enter

エディタを変更したい場合は次のとおりです。

```bash
git config --global core.editor "code --wait"
```

### `git log` などから抜けられない

`less` というページャの画面です。`q` を押してください。

---

## コマンド早見表

### 設定

| コマンド | 意味 |
|---|---|
| `git config --global user.name "名前"` | 名前を設定 |
| `git config --global user.email "メール"` | メールアドレスを設定 |
| `git config --global --list` | 設定を一覧表示 |

### 基本操作

| コマンド | 意味 |
|---|---|
| `git init` | リポジトリを作る |
| `git clone URL` | リポジトリを複製する |
| `git status` | 状態を確認する |
| `git add ファイル` | ステージに載せる |
| `git add .` | すべての変更をステージに載せる |
| `git commit -m "メッセージ"` | 記録する |
| `git commit --amend` | 直前のコミットをやり直す |

### 履歴を見る

| コマンド | 意味 |
|---|---|
| `git log --oneline` | 履歴を1行ずつ表示 |
| `git log --oneline --graph --all` | 枝分かれを図で表示 |
| `git diff` | まだaddしていない変更を見る |
| `git diff --staged` | addした変更を見る |
| `git show コミットID` | 特定のコミットを見る |
| `git blame ファイル` | 行ごとの由来を見る |

### やり直す

| コマンド | 意味 |
|---|---|
| `git restore ファイル` | 編集を捨てる |
| `git restore --staged ファイル` | ステージから降ろす |
| `git reset HEAD~1` | コミットを取り消す（変更は残る） |
| `git reset --hard HEAD~1` | 完全に巻き戻す |
| `git revert コミットID` | 打ち消すコミットを作る |
| `git reflog` | 移動の記録を見る |

### ブランチ

| コマンド | 意味 |
|---|---|
| `git branch` | ブランチ一覧 |
| `git branch -a` | リモートも含めた一覧 |
| `git switch -c 名前` | 作って移動 |
| `git switch 名前` | 移動 |
| `git switch -` | 直前のブランチに戻る |
| `git merge 名前` | 取り込む |
| `git merge --abort` | マージを中止 |
| `git branch -d 名前` | 削除 |

### リモート

| コマンド | 意味 |
|---|---|
| `git remote -v` | リモート一覧 |
| `git remote add origin URL` | リモートを登録 |
| `git push -u origin ブランチ` | 初回のpush |
| `git push` | 2回目以降のpush |
| `git fetch` | 情報だけ取ってくる |
| `git pull` | 取ってきて合流する |
| `git fetch --prune` | 消えたブランチの情報を整理 |

### 一時退避

| コマンド | 意味 |
|---|---|
| `git stash push -u -m "作業退避"` | 未追跡ファイルを含めて変更を退避する |
| `git stash list` | 退避の一覧 |
| `git stash pop` | 退避を戻す（コンフリクトすることがある） |
| `git stash drop` | 退避を捨てる |

### ファイル操作コマンドの対応表

`git` で始まるコマンドはどの環境でも同じですが、ファイル操作のコマンドだけは書き方が違います。この本で使ったものをまとめておきます。

| やりたいこと | macOS / Linux | Windows（PowerShell 7） |
|---|---|---|
| 移動する | `cd ~/git-practice` | `cd ~/git-practice` |
| いまの場所を見る | `pwd` | `pwd` |
| 一覧を見る | `ls` | `ls` |
| 隠しファイルも見る | `ls -a` | `ls -Force` |
| フォルダを作る | `mkdir -p 名前` | `mkdir 名前` |
| 空のファイルを作る | `touch 名前` | `New-Item -ItemType File 名前` |
| ファイルの中身を見る | `cat 名前` | `cat 名前` |
| 文字を書き込む | `echo "文字" > 名前` | `echo "文字" > 名前` |
| フォルダごと削除する | Finderやファイルマネージャーで削除 | エクスプローラーで削除 |
| 公開鍵をコピーする | `pbcopy < ファイル`（macOS） | `Get-Content ファイル \| Set-Clipboard` |

:::message alert
フォルダごとの削除は、まずGUIで対象を確認して削除するのが安全です。CLIが必要な場合は、削除前に `pwd` と `ls` で現在地と対象名を確認してください。macOS/Linuxでは `rm -rf 名前`、PowerShellでは `Remove-Item -Recurse -Force 名前` を使えますが、どちらも削除した内容を簡単には戻せません。
:::

Linuxのクリップボード操作はデスクトップ環境によって異なります。たとえば、X11では `xclip`、Waylandでは `wl-copy` を別途インストールして使います。利用できない場合は、公開鍵を表示して手動でコピーしてください。

---

## 自力で調べる方法

### コマンドのヘルプを見る

```bash
git help commit
git commit --help
```

ブラウザや `less` で詳しい説明が開きます。オプションが多すぎて圧倒されますが、「こんなオプションがあるのか」と眺めるだけでも発見があります。

短い説明でよければ、次のように書きます。

```bash
git commit -h
```

### Gitの出力をよく読む

Gitはとても親切なツールで、エラーメッセージの中に**対処法が書かれていること**がほとんどです。

```
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. If you want to integrate the remote changes, use
hint: 'git pull' before pushing again.
```

英語で長いので読み飛ばしたくなりますが、`hint:` の行には答えが書いてあります。慌てて検索する前に、まず画面を読んでみてください。

---

## この章のまとめ

- 困ったらまず `git status`、`git log --oneline --graph --all`、`git branch -a`
- コミットしてあれば、`git reflog` で探して救出用ブランチに保護する
- Gitのエラーメッセージには対処法が書いてある
- 早見表は、覚えようとせず必要なときに見返す

---

次が最後の章です。ここまでの振り返りと、次のステップを紹介します。
