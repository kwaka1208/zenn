---
title: GitHubに公開する（remote と push）
---

この章では、ローカルで作ってきた `my-notes` リポジトリを、GitHubにアップロードします。

---

## リモートリポジトリを作る

まず、GitHub側に受け皿を用意します。

1. GitHubにログインし、画面の **+** メニューなどから **New repository**（新しいリポジトリの作成）を開きます
2. 次の項目を入力します

| 項目 | 入力内容 |
|---|---|
| **Repository name** | `my-notes` |
| **Description** | 「日々のメモを管理するリポジトリ」など（任意） |
| **Visibility** | 練習なので `Private` がおすすめ |
| **Add a README file** | **チェックしない** |
| **Add .gitignore** | **None のまま** |
| **Choose a license** | **None のまま** |

3. **Create repository** をクリック

GitHubの画面名や項目の並びは変更されることがあります。大切なのは、`my-notes` という名前で、README・`.gitignore`・ライセンスを自動作成しない**空のリポジトリ**を作ることです。

:::message alert
最後の3項目でファイルを自動作成しないことが重要です。作成するとGitHub側でコミットが作られ、ローカルの履歴と食い違って、最初のpushが拒否されます。

すでにローカルにリポジトリがある場合は、空のリモートを作るのが正解です。
:::

### PublicとPrivateの違い

| | Public | Private |
|---|---|---|
| 誰が見られるか | インターネット上の誰でも | 自分と、招待した人だけ |
| 用途 | 公開したいコード、ポートフォリオ | 個人的なもの、仕事のコード |
| 基本的な利用 | 無料で作成できる | 無料で作成できる |

どちらもあとから変更できます。迷ったらPrivateで作り、公開したくなったら切り替えるのが安全です。

:::message
Privateリポジトリ自体は無料で作成できますが、ブランチ保護、Rulesets、GitHub Pages、Draft PRなど、後続章で扱う一部機能の利用条件や表示は、リポジトリの公開範囲、契約プラン、組織の設定によって異なる場合があります。

演習画面が表示されない場合は、Publicへ切り替える、対応するプランを使う、またはその節は説明だけ読む、のいずれかを選んでください。提供条件は変更されることがあるため、実際に利用するときはGitHub公式の最新プランを確認してください。
:::

---

## リモートのURLを確認する

作成後の画面に、次のような案内が表示されます。

```
…or push an existing repository from the command line

git remote add origin git@github.com:taro/my-notes.git
git branch -M main
git push -u origin main
```

リポジトリの **Code** メニューなどで**SSH**のURLを選びます。`git@github.com:` で始まっていればSSHです。画面の配置が異なる場合も、URLの先頭で確認できます。

---

## `git remote add` でリモートを登録する

ローカルのリポジトリに「送り先」を教えます。

```bash
cd ~/git-practice/my-notes
git remote add origin git@github.com:taro/my-notes.git
```

`taro` の部分は自分のユーザー名に置き換えてください。

### `origin` とは

`origin` は、リモートリポジトリに付けた**あだ名**です。毎回長いURLを打つのは大変なので、短い名前を付けているだけです。

技術的には別の名前でもかまいませんが、「メインのリモートは `origin`」というのがGit全体の慣習になっています。特別な理由がなければ `origin` にしてください。

登録されたか確認します。

```bash
git remote -v
```

```
origin	git@github.com:taro/my-notes.git (fetch)
origin	git@github.com:taro/my-notes.git (push)
```

`fetch`（取ってくる先）と `push`（送る先）の2行が表示されれば成功です。

:::details URLを間違えたとき
登録し直すのではなく、変更コマンドを使います。

```bash
git remote set-url origin git@github.com:taro/my-notes.git
```

削除したいときは次のとおりです。

```bash
git remote remove origin
```
:::

---

## `git push` でアップロードする

いよいよ送信します。

```bash
git push -u origin main
```

```
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (12/12), 1.05 KiB | 1.05 MiB/s, done.
Total 12 (delta 1), reused 0 (delta 0), pack-reused 0
To github.com:taro/my-notes.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

成功です。ブラウザでGitHubのリポジトリページを再読み込みすると、`README.md` と `notes/` が表示されているはずです。

### コマンドの意味

```
git push -u origin main
         │  │      └ ローカルの main ブランチを
         │  └ origin という名前のリモートへ
         └ 対応関係を覚えておく
```

`-u` は `--set-upstream` の略で、「このローカルブランチは、このリモートブランチとつながっている」という関係を記録します。

一度これをやっておくと、次からは省略できます。

```bash
git push
```

:::message
`-u` が必要なのは、そのブランチの初回pushのときだけです。2回目以降は `git push` だけでかまいません。
:::

---

## 変更を追加してpushする

実際の使い方を確認しましょう。ファイルを編集します。

```markdown:notes/todo.md
# やること

- [x] 牛乳を買う
- [ ] 図書館に本を返す
- [ ] Gitの練習をする
- [ ] GitHubにpushしてみる
```

いつもの流れでコミットして、pushします。

```bash
git add notes/todo.md
git commit -m "todoの進捗を更新"
git push
```

GitHubの画面を更新すると、変更が反映されています。

**この「編集 → add → commit → push」が、Gitを使う日常のリズム**です。これを繰り返していくことになります。

---

## GitHubの画面を見てみる

pushしたリポジトリの **Code** 画面で、いくつか見ておきましょう。GitHubの配置は変わることがありますが、次の内容を確認できれば成功です。

### コミット履歴

ファイル一覧の上部にあるコミット数のリンクを開きます。時計のアイコンや最新コミットの情報として表示される場合もあります。`git log` と同じ履歴が見られ、各コミットを開くと差分（`git diff` の内容）も確認できます。

### ファイルの中身

ファイル名をクリックすると中身が表示されます。Markdownファイルは、書式が反映された状態で読めます。

### README.mdの役割

リポジトリのトップページには、`README.md` の中身が自動的に表示されます。「このリポジトリは何なのか」を説明する看板の役割です。

せっかくなので、少し充実させてみましょう。

````markdown:README.md
# わたしのメモ帳

日々のメモを Markdown で管理するリポジトリです。

## 構成

- `notes/todo.md` … やることリスト
- `notes/books.md` … 読みたい本のリスト

## 使い方

メモを編集したら、コミットして push します。

```bash
git add .
git commit -m "メモを更新"
git push
```
````

コミットしてpushします。

```bash
git add README.md
git commit -m "READMEに構成と使い方を追記"
git push
```

---

## pushが拒否されたとき

しばらく使っていると、次のエラーに出会うことがあります。

```
! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'github.com:taro/my-notes.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally.
```

これは「**リモートに、あなたがまだ持っていない変更があります**」という意味です。GitHubの画面上でファイルを編集した、別のパソコンからpushした、といったときに起こります。

いきなり統合せず、まずリモートの最新情報だけを取得します。この章では `main` ブランチを使っている前提です。

```bash
git fetch origin
```

リモートにだけあるコミットと、その差分を確認します。

```bash
git log --oneline --graph --decorate main..origin/main
git diff main..origin/main
```

内容を理解し、取り込んでよいと判断できたら統合します。

```bash
git merge origin/main
```

競合が起きた場合は内容を解決し、`git status` や必要な動作確認で問題がないことを確かめてからpushします。

```bash
git push
```

次の章「取ってくる（clone・fetch・pull）」では、取得と統合の関係を詳しく扱います。

:::message alert
このエラーを `git push --force` で押し通すと、リモートにある変更を失わせる可能性があります。まず `fetch` し、履歴と差分を確認してから統合してください。共有リポジトリでは、理由を理解しないままforce pushを使いません。
:::

---

## この章のまとめ

- GitHubで空のリポジトリを作る（README等を自動作成しない）
- GitHubのUIが変わっても、ラベルと作成結果で確認する
- 一部機能の利用条件は、公開範囲やGitHubのプランによって異なる
- `git remote add origin URL` で送り先を登録する
- 初回は `git push -u origin main`、2回目以降は `git push`
- 日常のリズムは「編集 → add → commit → push」
- pushが拒否されたら、`fetch` → 履歴と差分の確認 → `merge` → `push`
- `--force` は安易に使わない

---

次の章では、GitHubにあるリポジトリを別の場所に持ってくる方法を学びます。
