---
title: Gitの準備と初期設定
---

この章では、Gitが使える状態にして、最初の設定を済ませます。ここを飛ばすと後の章でエラーになるので、必ず確認してください。

---

## ターミナルを開く

Gitはコマンドラインから操作します。まずはターミナルを開きましょう。

- **macOS**: 「アプリケーション」→「ユーティリティ」→「ターミナル」。Spotlight検索（`command + スペース`）で「ターミナル」と入力してもかまいません
- **Windows**: スタートメニューから「PowerShell 7」を開きます。見つからない場合は、次の節でインストールしてください
- **Linux**: 使っているデスクトップ環境の端末アプリを開きます

黒い画面（設定によっては白い画面）に、次のような行が表示されていれば準備完了です。

macOS / Linux:

```
username@machine ~ %
```

Windows（PowerShell 7）:

```
PS C:\Users\taro>
```

この行を**プロンプト**と呼びます。この後ろにコマンドを入力してEnterを押す、というのが基本の操作です。

:::message
この本のコマンド例では、プロンプト部分（`$` `%` `PS C:\Users\taro>` など）は書きません。コードブロックの中身をそのまま入力してください。
:::

---

## PowerShell 7 を用意する（Windowsのみ）

Windowsには、名前のよく似たものが2つ入っています。

| 名前 | アイコン | この本での扱い |
|---|---|---|
| **Windows PowerShell**（5.1） | 青地 | 使いません |
| **PowerShell**（7以降） | 黒地 | **こちらを使います** |

古いほうの5.1は、ファイルに文字を書き込むときの文字コードが特殊（UTF-16）で、この本の手順どおりに進めても結果が変わってしまうことがあります。7以降ではUTF-8が標準になったため、macOSやLinuxと同じ感覚で進められます。

いま開いている画面がどちらかは、次のコマンドでわかります。

```powershell
$PSVersionTable.PSVersion
```

`Major` が `7` 以上なら、そのまま次へ進んでください。`5` と表示された場合は、次のコマンドでPowerShell 7 をインストールします。

```powershell
winget install --id Microsoft.PowerShell -e
```

インストールが終わったら、いまの画面を閉じ、スタートメニューから改めて「PowerShell 7」を開き直してください。

:::message
`winget` は、Windows 10（バージョン1809以降）とWindows 11に標準で入っているインストール用のコマンドです。使えない場合は、Microsoft Storeで「PowerShell」を検索してインストールすることもできます。
:::

---

## Gitが入っているか確認する

まず、Gitがすでにインストールされているかを確認します。

```bash
git --version
```

次のようにバージョン番号が表示されれば、インストール済みです。

```
git version 2.39.5
```

:::message
バージョンが2.23より古い場合、この本で使う `git switch` や `git restore` というコマンドが使えません。その場合は次の節を参考にアップデートしてください。
:::

次のように表示された場合は、インストールが必要です。

macOS / Linux:

```
command not found: git
```

Windows（PowerShell 7）:

```
git : 用語 'git' は、コマンドレット、関数、スクリプト ファイル、または操作可能なプログラムの名前として認識されません。
```

---

## Gitをインストールする

### macOS

Homebrewを使うのがおすすめです。

```bash
brew install git
```

Homebrewが入っていない場合は、次のコマンドでも導入できます（Xcodeコマンドラインツールに含まれるGitがインストールされます）。

```bash
xcode-select --install
```

### Windows

```powershell
winget install --id Git.Git -e
```

インストールが終わったら、PowerShellを一度閉じて開き直してください。開き直さないと、`git` コマンドがまだ見つからないことがあります。

### Linux

```bash
sudo apt update
sudo apt install git -y
```

インストールが終わったら、もう一度 `git --version` を実行して確認してください。

:::message
インストールでつまずいた場合は、次の本の「Gitのインストール」の章に、より詳しい手順があります。

https://zenn.dev/kwaka1208/books/dev-env-setup
:::

---

## 名前とメールアドレスを登録する

Gitは「誰がこの変更を記録したのか」を履歴に残します。そのため、最初に名前とメールアドレスを登録する必要があります。**これをやらないと、最初のコミットでエラーになります。**

```bash
git config --global user.name "Taro Yamada"
git config --global user.email "taro@example.com"
```

`"..."` の中は自分のものに書き換えてください。

### どんな名前とメールアドレスにすればいい？

- **名前**: 本名でもハンドルネームでもかまいません。GitHubで使う名前と揃えておくと見やすくなります
- **メールアドレス**: 普段使っているもので問題ありません

:::message alert
ここで登録したメールアドレスは、**コミット履歴に残り、公開リポジトリでは誰でも見られる状態になります**。プライベートなアドレスを知られたくない場合は、GitHubが用意する非公開用アドレス（`12345678+username@users.noreply.github.com` という形式）を使えます。第8章でアカウントを作ったあと、GitHubの設定画面から確認して、この設定を上書きしてください。
:::

### `--global` とは

`--global` は「このパソコン全体の設定として登録する」という意味です。この設定をしておけば、これから作るすべてのリポジトリで同じ名前・メールアドレスが使われます。

仕事用と個人用でメールアドレスを分けたいときは、そのリポジトリの中で `--global` を外して実行すると、そのリポジトリだけの設定になります。

---

## 標準ブランチ名を設定する

Gitでは、最初にできる作業ラインを**ブランチ**と呼びます。古いGitでは `master`、最近は `main` という名前が使われます。GitHubも `main` を標準としているので、揃えておきましょう。

```bash
git config --global init.defaultBranch main
```

ブランチについては第11章で詳しく説明します。いまは「作業ラインの名前を `main` に揃えた」とだけ理解しておけば大丈夫です。

---

## 設定を確認する

登録した内容を確認します。

```bash
git config --global --list
```

次のように表示されれば成功です。

```
user.name=Taro Yamada
user.email=taro@example.com
init.defaultBranch=main
```

個別に確認したいときは、項目名を指定します。

```bash
git config --global user.name
```

---

## 日本語表示の設定（推奨）

日本語のファイル名を扱うとき、Gitの標準設定では次のように文字化けして表示されることがあります。

```
"\343\203\241\343\203\242.md"
```

これを読める形にするには、次の設定を入れます。

```bash
git config --global core.quotepath false
```

:::message
この設定を入れなくても、Gitは問題なく動きます。変わるのは**画面に表示される文字列だけ**で、記録されるファイル名やコミットの中身はまったく同じです。日本語のファイル名を使わないうちは、違いに気づくこともありません。読みにくいと感じたときに入れれば十分です。
:::

---

## 作業用フォルダを作る

最後に、これから作業する場所を用意します。ホームディレクトリの下に、練習用のフォルダを作りましょう。

macOS / Linux:

```bash
cd ~
mkdir -p git-practice
cd git-practice
```

Windows（PowerShell 7）:

```powershell
cd ~
mkdir git-practice
cd git-practice
```

それぞれのコマンドの意味は次のとおりです。

| コマンド | 意味 |
|---|---|
| `cd ~` | ホームディレクトリに移動する（`~` がホームを表す） |
| `mkdir git-practice` | `git-practice` というフォルダを作る |
| `cd git-practice` | 作ったフォルダの中に移動する |

:::message
macOS / Linux で付けている `-p` は、「同じ名前のフォルダがすでにあってもエラーにしない」という指定です。PowerShellの `mkdir` にはこのオプションがないため、付けずに実行します。
:::

いまどこにいるかは、次のコマンドで確認できます。

```bash
pwd
```

macOS:

```
/Users/taro/git-practice
```

Windows（PowerShell 7）:

```
C:\Users\taro\git-practice
```

この場所が、これからの作業拠点です。

:::message
ターミナルを閉じると、次に開いたときはホームディレクトリに戻ります。作業を再開するときは `cd ~/git-practice` で戻ってきてください。
:::

---

## この章のまとめ

- `git --version` でインストールを確認する
- `git config --global user.name` と `user.email` の登録は必須
- `init.defaultBranch` を `main` にしておくとGitHubと揃う
- 作業フォルダ `~/git-practice` を用意した

---

次の章では、いよいよリポジトリを作ります。
