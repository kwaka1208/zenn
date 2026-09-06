# 残課題メモ（git-github-tutorial）

2026-09-07 の事実確認で洗い出した指摘のうち、**未対応のまま残っているもの**の記録。
指摘の全体像と対応済みの内容は `~/.claude/plans/books-git-github-tutorial-jaunty-seal.md` を参照。

> このファイルは `config.yaml` の `chapters` に載せていないため、本のチャプターとしては公開されません。

---

## 1. PowerShell 7 の `New-Item` の挙動（未検証）

**該当箇所**

- `03_first-repo.md` … `New-Item README.md`
- `07_gitignore.md` … `New-Item .gitignore`
- `15_troubleshoot.md` … 対応表の「空のファイルを作る … `New-Item 名前`」

**内容**

`-ItemType` を省略した `New-Item <ファイル名>` が、対話プロンプト（`ItemType:` の入力待ち）を出さずに
空ファイルを作るかどうかが確認できていない。プロンプトが出る場合、読者は「Enterを押しても先に進まない」
状態になり、この本の想定（`touch` 相当のワンライナー）から外れる。

**未対応の理由**

macOS 環境のため Windows 実機で検証できなかった。推測で書き換えると別の誤りを生むため、現状維持とした。

**確認方法**

Windows の PowerShell 7 で次を実行し、プロンプトが出ずにファイルができるかを見る。

```powershell
New-Item README.md
```

**プロンプトが出た場合の修正案**

3ファイルとも `-ItemType File` を明示する。プロンプトの有無にかかわらず確実に動く。

```powershell
New-Item -ItemType File README.md
```

あわせて `15_troubleshoot.md` の対応表の「空のファイルを作る」の行も、
Windows 側を `New-Item -ItemType File 名前` に揃える。

---

## 2. 第6章 `git reflog` の例に第5章のコミットが現れない（軽微・判断保留）

**該当箇所**: `06_undo.md` の `git reflog` 出力例

```
7f3a9c2 (HEAD -> main) HEAD@{0}: reset: moving to HEAD~1
e8d9a0b HEAD@{1}: commit: 消してしまったコミット
7f3a9c2 HEAD@{2}: commit: todoに項目を追加
4d5e6f7 HEAD@{3}: commit: メモ用のnotesフォルダを追加
```

第6章の時点では、第5章の「読みたい本に「こころ」を追加」がすでに済んでいるはずで、
本来ならその行が `HEAD@{2}` あたりに入る。

**未対応の理由**

この reflog は「コミットを消してしまった」という**架空のシナリオ**の説明用で、
本編の履歴を忠実に再現したものではない。学習上の実害がないと判断して現状維持とした。
履歴の一貫性を優先するなら、`読みたい本に「こころ」を追加` の行を足す。

---

## 3. `config.yaml` の `published` 変更（本作業の対象外）

`published: false → true` の変更は今回の事実確認を始める前から作業ツリーに入っていたもので、
こちらでは触れていない。コミットするかどうかは要判断。

---

## 補足: 今回の修正で実機検証済みの項目

第9章終了時点から第13章のPRマージまでを再現し、本文の出力例と一致することを確認済み。

- 第12章 fast-forward / マージコミット / コンフリクト表示
- 第13章 PRマージがコンフリクトしないこと、および差分統計

Git 2.30.1（macOS）で検証。`'ort' strategy` の表示のみ Git 2.34 以降が必要なため、
手元では `'recursive'` と出るが、本文は現行バージョンに合わせて `'ort'` としている。
