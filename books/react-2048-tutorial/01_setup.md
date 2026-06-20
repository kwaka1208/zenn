---
title: 開発環境とプロジェクトの作成
---

## 必要なツールを確認する

まず、開発に必要な**Node.js**がインストールされているか確認します。

ターミナル（Macはターミナル.app、WindowsはPowerShell）を開いて、次のコマンドを入力してください。

```bash
node -v
```

`v20.12.0` 以上のバージョン番号が表示されれば準備OKです。

```
v22.0.0   ← このように表示されればOK
```

表示されない場合や古いバージョンの場合は [Node.js公式サイト](https://nodejs.org/ja) からLTS版をインストールしてください。

---

## Reactプロジェクトを作成する

Reactプロジェクトの作成には**Vite（ヴィート）**というツールを使います。Viteは開発サーバーの起動が速く、最近のReact開発でよく使われています。

TypeScript対応のテンプレートを指定して、次のコマンドを実行してください。

```bash
npm create vite@latest react-2048 -- --template react-ts
```

`--template react-ts` の `ts` がTypeScript対応を意味します。

完了したら、作成されたフォルダに移動して、必要なパッケージをインストールします。

```bash
cd react-2048
npm install
```

---

## 開発サーバーを起動する

インストールが終わったら、開発サーバーを起動します。

```bash
npm run dev
```

ターミナルに次のような表示が出たら成功です。

```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
```

ブラウザで `http://localhost:5173/` を開くと、Reactのデフォルト画面が表示されます。

---

## フォルダ構成を確認する

作成されたフォルダの中身を確認してみましょう。実際には次のようなファイルが生成されています。

```
react-2048/
├── node_modules/        # インストールされたパッケージ（触らない）
├── public/              # 静的ファイル（画像など）
├── src/                 # ソースコード（ここを編集していく）
│   ├── assets/          # 画像などのアセット
│   ├── App.css          # App コンポーネントのスタイル
│   ├── App.tsx          # メインのコンポーネント（TypeScript + JSX）
│   ├── index.css        # 全体のスタイル
│   └── main.tsx         # エントリーポイント（起点）
├── .gitignore           # Gitの管理対象外ファイルの設定
├── eslint.config.js     # コード品質チェックツールの設定
├── index.html           # HTMLのベースファイル
├── package.json         # プロジェクトの設定・依存パッケージ一覧
├── package-lock.json    # パッケージのバージョンを固定するファイル
├── README.md            # プロジェクトの説明ファイル
├── tsconfig.json        # TypeScriptの設定ファイル
├── tsconfig.app.json    # アプリ用TypeScript設定
├── tsconfig.node.json   # Node.js用TypeScript設定
└── vite.config.ts       # Viteの設定ファイル
```

:::message
ファイルが多く見えますが、**このチュートリアルで直接編集するのは `src/` フォルダの中だけ**です。それ以外のファイルはViteが自動的に用意した設定ファイルなので、特に触る必要はありません。
:::

JavaScriptのプロジェクトとの違いは、ファイルの拡張子が `.jsx` / `.js` ではなく **`.tsx` / `.ts`** になっている点です。

| 拡張子 | 内容 |
|---|---|
| `.tsx` | TypeScript + JSX（コンポーネントファイル） |
| `.ts` | TypeScript（コンポーネント以外のファイル） |

これから主に `src/` フォルダの中を編集していきます。

---

## 不要なファイルをきれいにする

Viteが生成したデフォルトのファイルには不要なコードが含まれています。以降の作業をスムーズにするため、`src/App.tsx` と `src/App.css` の中身を書き換えます。

**`src/App.tsx`** を次の内容に書き換えてください。

```tsx
function App() {
  return (
    <div>
      <h1>2048</h1>
    </div>
  );
}

export default App;
```

**`src/App.css`** の中身はすべて削除して、空のファイルにしてください。

保存すると、ブラウザが自動的に更新されて「2048」という文字だけが表示されます。

---

## まとめ

- `npm create vite@latest -- --template react-ts` でTypeScript対応のReactプロジェクトを作成しました
- TypeScriptのファイルは `.tsx` / `.ts` という拡張子を使います
- `npm run dev` で開発サーバーを起動しました

次の章では、Reactの基本的な概念（コンポーネント・JSX・Props）をTypeScriptと合わせて学びます。
