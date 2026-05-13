---
title: "環境を整えよう（インストール）"
---
Node.jsのインストールには、バージョン管理ツールを使うのが一般的です。ここでは、高速で使いやすい `fnm` (Fast Node Manager) を使った方法を紹介します。

## 1. fnmのインストール
OSに合わせて以下のコマンドを実行します。

### macOS / Linux
```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

### Windows (PowerShell)
```powershell
winget install Schniz.fnm
```

## 2. Node.jsのインストール
fnmがインストールできたら、最新のLTS（長期サポート版）をインストールします。

```bash
fnm install --lts
fnm use lts-latest
```

## 3. 確認
正しくインストールされたか確認しましょう。

```bash
node -v
```

バージョン番号（例: `v22.x.x`）が表示されれば成功です！
