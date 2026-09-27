# 残課題メモ（git-github-tutorial）

未対応の事項だけを記録する。このファイルは `config.yaml` の `chapters` に含まれないため、本のチャプターとしては公開されない。

---

## 1. PowerShell 7の空ファイル作成コマンドを統一する

`New-Item` の項目種別を省略せず、空ファイルを作ることが明確な次の形式へ統一する。

```powershell
New-Item -ItemType File ファイル名
```

`15_troubleshoot.md` は対応済み。編集範囲外だった次の2箇所が未対応。

- `03_first-repo.md` の `New-Item README.md`
- `07_gitignore.md` の `New-Item .gitignore`

---

## 2. 第6章のreflog救出手順を非破壊的にする

`06_undo.md` のreflogからの救出では、最初の手段として `git reset --hard` を案内している。現在の未コミット変更を失う可能性があるため、次の順序へ変更する必要がある。

1. `git reflog` で救出対象のコミットIDを確認する
2. `git branch rescue コミットID` で救出用ブランチを作る
3. 内容を確認し、必要なら `git switch rescue` で切り替える
4. `git reset --hard` は、現在の変更が不要または退避済みと確認できた場合だけの最終手段にする

`15_troubleshoot.md` の同種の手順は対応済み。`06_undo.md` は今回の編集範囲外だったため未対応。
