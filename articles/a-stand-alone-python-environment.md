---
title: "管理者権限がなく、pipでモジュールインストールできないWindows PCにPython環境を構築する手順"
emoji: "🐍"
type: tech
topics: [python]
published: true
---
## 概要
このページでは、限られた条件下にあるPCにPythonの動作環境を構築する手順を説明しています。対象はWindows PCのみとなります。

また、この記事ではディレクトリ（フォルダ）配置なども具体的に限定的に記述していますが、まったくの初心者でもここに書いてあるとおり進めれば環境を作れるようにするためのものです。ご自身の環境に合わせて適宜読み替えてください。

## コマンドラインでの操作
Pythonの実行環境の構築と自分で作ったPythonのプログラムの実行は、いずれも「コマンドライン」で行います。通常、Windowsではアプリの操作をマウスなどポインティングデバイスで行いますが、コマンドラインではコマンドをキーボードから入力してプログラムの実行などの操作を行います。

コマンドライン操作を行うためには「コマンドプロンプト」というアプリを利用します。コマンドプロンプトは以下の手順で実行します。

1. Windowsキーと"R"キーを押します。
1. 「ファイル名を指定して実行」というウインドウが表示されますので"cmd"を入力してENTERを押します。
3. 黒いウインドウが表示されますので、そのウインドウの中でコマンドの入力を行います。

以下「コマンドプロンプトを開きます」という説明のところでは、上記の手順でコマンドプロンプトを実行してください。一度コマンドプロンプトを開いていれば、その後の作業は連続して行えます。また、複数のコマンドプロンプトを同時に起動できます。

## Pythonのインストール  
1. [Pythonの公式サイト](https://www.python.org/downloads/windows/)から" Windows embeddable package (64-bit)"をダウンロードして展開します。
2. 展開したフォルダの名前を"python"に変更します。
3. このフォルダを適当な場所へ移動します。ここでは"D:\username\"の下へ移動するものとします。つまりPythonのインストール場所は"D:\username\python"となります。

## 環境変数の設定
環境変数とは、Windows上でプログラム（Pythonを含む）を動かすのに必要な情報のことを言います。通常は意識する必要はありませんが、ここではいわゆる「インストーラー」を使わずにインストールしているため、手動で行わなければなりません。

1. 以下の内容をコピーして、メモ帳に貼り付け"env.bat"というファイル名でPythonをインストールしたフォルダに保存します。。

```
@echo off

rem カレントディレクトリの取得
set "current_dir=%CD%"
set PATH="%PATH%;%current_dir%\Lib\site-packages;%current_dir%\Scripts"
```

1. コマンドプロンプトを開きます。
1. 以下の手順でPythonがインストールされているディレクトリへ移動します。
```
D: [ENTER]
cd \username\python
```
1. ここで先ほど作成した"env.bat"を実行します。コマンドプロンプトで"env"と入力して"ENTER"を押してください。

```
env [ENTER]
```

以上で環境変数の設定は完了です。

## 設定ファイルの変更
Pythonをインストールしたディレクトリの中にある"python310._pth"（310の数字の部分はバージョンによって異なります）をメモ帳で開き、以下のように編集して保存します。

```
import site # 先頭の#を削除する
./Lib/site-packages #この行を追加
```

## モジュールのインストール
Pythonには多数のモジュールと呼ばれる多数のプログラムが公開されており、これらを利用することで高度な機能を持つプログラムを作れます。

### モジュールのダウンロード手順
1. Pythonのフォルダの中に"dl"フォルダを作成します。
1. 以下の手順でダウンロードしたファイルを"dl"フォルダに置きます。
    1. [PyPI](https://pypi.org/)にアクセスします。
    1. 「プロジェクトを検索」のところにインストールしたいモジュールの名前を入力して検索します（必要なモジュールの名前は以下をご覧ください）。
    1. 検索結果からインストールしたいモジュールの名前をクリックします。
    1. 表示されたページの左側にあるメニューから「ファイルをダウンロード」をクリックします。  
    ![](/images/python/install01.png)
    1. 表示されたページの"Built Distribution"の下にある、".whl"で終わるファイル名をクリックしてダウンロードします（画像はsetuptoolsモジュールの場合）。  
    ![](/images/python/install02.png)
    1. ダウンロードしたファイルを"dl"フォルダに移動します。


### モジュールをインストールするツール"pip"のインストール
まず、モジュールをインストールするのに必要な"pip"というツールをインストールします。pipのインストールに必要なモジュールは以下の3つです。それぞれのリンクをクリックするとダウンロードページが表示されますので、上記「モジュールのダウンロード手順」を参考に"dl"フォルダにファイルを置いてください。

- pipのインストールに必要なモジュール
    - [setuptools](https://pypi.org/project/setuptools/)
    - [pip](https://pypi.org/project/pip/)
    - [wheel](https://pypi.org/project/wheel/)

また、pipをインストールするためのファイルをこちらからダウンロードします。

[このリンクを右クリックし、リンク先を保存してください](https://bootstrap.pypa.io/get-pip.py)

ダウンロードしたファイル（get-pip.py)をPythonをインストールしたフォルダに置いてください。今回であれば"D:\username\python"になります。

### pipのインストール
pipのインストールを以下の手順で行います。

1. コマンドプロンプトを開きます。
1. Pythonがインストールされているディレクトリへ移動します。
1. インストールのためのコマンドを実行します（以下参照）。
1. この時、WARNINGというメッセージが繰り返し表示されることがありますが、無視してください。"Successfully installed pip setuptools wheel"というメッセージが表示されたら完了です。

```
D: [ENTER]
cd \username\python
python get-pip.py --find-links=dl pip
```

以上で、モジュールをインストールするためのツールのインストールが終わりました。これは一度だけやっておけば構いません。

## その他のモジュールのインストール
pipのインストールができたら、必要なモジュールを以下の手順でインストールできます。

1. モジュールファイルをダウンロードします（モジュールのダウンロード手順を参照してください）。
1. コマンドプロンプトを開きます。
1. Pythonがインストールされているディレクトリへ移動します。
1. 以下のコマンドを実行します、{モジュール名}のところにインストールしたいモジュールの名前を入力します。
1. "Successfully installed {モジュール名}"のメッセージが出れば完了です。

```
python -m pip install --no-index --find-links=dl {モジュール名}
```

モジュールは一度インストールすれば、複数のプログラムで利用できます。同じモジュールを利用するPythonプログラムを複数作る場合でも、モジュールのインストール操作は一回のみで結構です。

## よく使われるモジュールのインストール

### openpyxl
openpyxlは、PythonでExcelのファイルを操作するプログラムを作成するために必要なモジュールです。

#### モジュールファイルのダウンロード
以下のファイルをダウンロードして、"dl"フォルダに置きます。
- [openpyxl](https://pypi.org/project/openpyxl/)
- [et-xmlfile](https://pypi.org/project/et-xmlfile/)

#### モジュールのインストール
コマンドプロンプトで以下の操作を行ってください。

```
python -m pip install --no-index --find-links=dl openpyxl
```

### requests
requestsは、webサイトへアクセスするためのモジュールです。webサイトに掲載されたデータの取得などに用いられます。ただし、プログラムを使った大量のアクセスは対象のwebサイトに負荷をかける恐れがありますので、設計と検証を十分に行ってください。

#### モジュールファイルのダウンロード
以下のファイルをダウンロードして、"dl"フォルダに置きます。
- [requests](https://pypi.org/project/requests/)
- [charset_normalizer](https://pypi.org/project/charset-normalizer/)
- [idna](https://pypi.org/project/idna/)
- [urllib3](https://pypi.org/project/urllib3/)
- [certifi](https://pypi.org/project/certifi/)

#### モジュールのインストール
コマンドプロンプトで以下の操作を行ってください。

```
python -m pip install --no-index --find-links=dl requests
```
### beautifulsoup4
beautifulsoup4はwebサイトのデータから必要な情報を抽出する際に使われるモジュールです。一般的には、requestsとペアで使われます。

#### モジュールファイルのダウンロード
以下のファイルをダウンロードして、"dl"フォルダに置きます。
- [beautifulsoup4](https://pypi.org/project/beautifulsoup4/)
- [soupsieve](https://pypi.org/project/soupsieve/)

#### モジュールのインストール
コマンドプロンプトで以下の操作を行ってください。
```
python -m pip install --no-index --find-links=dl requests
```

### pdfrw2
PythonでPDFの加工を行うためのモジュールです。PDF同士の結合、ページの抜粋・回転・コピー・重ね合わせなどができます。

#### モジュールファイルのダウンロード
以下のファイルをダウンロードして、"dl"フォルダに置きます。
- [pdfrw2](https://pypi.org/project/pdfrw2/)

#### モジュールのインストール
コマンドプロンプトで以下の操作を行ってください。
```
python -m pip install --no-index --find-links=dl pdfrw2
```

## サンプルプログラム
### PDFを結合する
複数のPDFを結合するPythonプログラムの例を示します。

1. Pythonをインストールしたフォルダの中に"projects"というフォルダを作ります。
1. 以下のプログラムをテキストエディタにコピーして"projects"フォルダへ保存します（"merge_pdf.py"で保存するものとします）。

```
from pathlib import Path
from pdfrw import PdfWriter, PdfReader

# PDFファイル一覧を取得（ファイル名でソート）
pdf_dir = Path("./pdf_files")
pdf_files = sorted(pdf_dir.glob("*.pdf"))

# 結合先を用意
writer = PdfWriter()

# １つのPDFファイルにまとめる
for f in pdf_files:
    writer.addpages(PdfReader(f).pages)

# 保存ファイル名（先頭と末尾のファイル名で作成）
merged_file = "all.pdf"

writer.write('merged.pdf')
```
1. "projects"フォルダの下に"pdf_files"フォルダを作り、結合したいPDFファイルを置きます。結合順はファイル名の昇順になりますので、ファイル名の先頭に連番をつけておくとよいです。
1. コマンドプロンプトを開きます。
1. 以下の手順でプログラムを実行します。
1. 結合したファイルとして"merged.pdf"ができます。

```
D: [ENTER]
cd \username\python\projects
..\python.exe merge_pdf.py
```