---
title: "PATH の設定"
---

**PATH** は、コマンドを入力したときにシェルがプログラムを探しにいくディレクトリの一覧です。たとえば `git` と入力したとき、シェルは PATH に登録されたディレクトリを順番に調べて `git` という実行ファイルを見つけます。

ツールをインストールしたのに `command not found` と表示される場合は、そのツールがインストールされたディレクトリが PATH に登録されていないことが原因であることがほとんどです。

## 現在の PATH を確認する

どの OS でも以下のコマンドで確認できます（Windows は PowerShell）。

```bash
echo $PATH        # macOS / Linux / WSL
$env:PATH         # Windows (PowerShell)
```

コロン（macOS/Linux）またはセミコロン（Windows）区切りでディレクトリの一覧が表示されます。

## Windows (PowerShell) での設定

### GUI で設定する

1. スタートボタンを右クリックし、**「システム」** を選択します。
2. 右側の **「システムの詳細設定」** をクリックします。
3. **「環境変数」** ボタンをクリックします。
4. 「ユーザー環境変数」の `Path` を選択し、**「編集」** をクリックします。
5. **「新規」** をクリックし、追加したいディレクトリのパスを入力します。
6. **「OK」** を繰り返しクリックして閉じます。

設定後は PowerShell を再起動すると反映されます。

### PowerShell コマンドで設定する

```powershell
# ユーザー環境変数の PATH に追加（PC を再起動しても残る）
[System.Environment]::SetEnvironmentVariable(
  "PATH",
  $env:PATH + ";C:\your\tool\path",
  "User"
)
```

`C:\your\tool\path` の部分を実際のディレクトリパスに置き換えてください。

## Windows (WSL) / Linux (Ubuntu) での設定

`~/.bashrc`（bash の場合）または `~/.profile` に以下の行を追加します。

```bash
export PATH="$HOME/.local/bin:$PATH"
```

`$HOME/.local/bin` の部分を実際のディレクトリパスに置き換えてください。

追加後、ターミナルを再起動するか以下のコマンドで反映させます。

```bash
source ~/.bashrc
```

## macOS での設定

macOS のデフォルトシェルは **zsh** です。`~/.zshrc` に以下の行を追加します。

```bash
export PATH="/your/tool/path:$PATH"
```

`/your/tool/path` の部分を実際のディレクトリパスに置き換えてください。

追加後、ターミナルを再起動するか以下のコマンドで反映させます。

```bash
source ~/.zshrc
```

bash を使っている場合は `~/.bash_profile` が対象ファイルです。

## PATH の書き方のポイント

```bash
export PATH="/new/path:$PATH"
#            ^^^^^^^^^^^  ^^^^
#            追加したいパス  既存の PATH を末尾に付ける
```

- 新しいパスを **先頭に書く** と、同名のコマンドがあったときに優先されます。
- `$PATH` を忘れると既存のパスがすべて消えて、`ls` や `cd` など基本コマンドまで動かなくなります。必ず `$PATH` を含めてください。

## 設定が反映されているか確認する

**Windows (PowerShell)**

```powershell
Get-Command git
Get-Command python
```

**Windows (WSL) / Linux / macOS**

```bash
which git
which python3
```

正しいディレクトリが表示されれば、PATH の設定は成功しています。
