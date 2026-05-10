---
title: メール関係のDNS設定をチェックするスクリプト
emoji: "🔖"
type: idea
topics: [Mail, DNS, DKIM, DMARC, SPF]
published: true
---
## はじめに

この記事では、メール関係のDNS設定をチェックするためのスクリプトを紹介しています。新しいメールサーバーを設定した場合の確認時などにご利用ください。

https://github.com/kwaka1208/library/tree/main/checkdns

## スクリプトの概要

このツールは、特定のドメインに対して以下の情報を一度に取得することを目的としています。
特に、メールサーバーの設定（SPF, DKIM, DMARC）が正しく行われているかを確認する際に便利です。

1. Aレコード: Webサイトの接続先サーバー
2. MXレコード: メールの配送先サーバー
3. TXTレコード: SPF設定やドメイン所有権の確認用
4. DMARCレコード: なりすまし対策の設定 (`_dmarc` サブドメイン)
5. DKIMレコード: メールの電子署名用公開鍵 (`[selector]._domainkey` サブドメイン)

## 使い方

環境に応じて、シェルスクリプトまたはPowerShellスクリプトを使用できます。

### 1. シェルスクリプト (`checkdns.sh`)
Linux や macOS で使用します。

```bash
# 基本的な使い方
./checkdns.sh example.com

# DKIMセレクタを指定する場合
./checkdns.sh example.com google

# Google Public DNS (8.8.8.8) を使用して確認する場合
./checkdns.sh example.com -g

# 任意のDNSサーバーを指定する場合
./checkdns.sh example.com -s 1.1.1.1

# DKIMセレクタと任意のDNSサーバーを指定する場合
./checkdns.sh example.com google -s 1.1.1.1
```

### 2. PowerShellスクリプト (`checkdns.ps1`)
Windows で使用します。

```powershell
# 基本的な使い方
.\checkdns.ps1 example.com

# DKIMセレクタを指定する場合
.\checkdns.ps1 example.com google

# Google Public DNS (8.8.8.8) を使用して確認する場合
.\checkdns.ps1 example.com -g

# 任意のDNSサーバーを指定する場合
.\checkdns.ps1 example.com -s 1.1.1.1

# DKIMセレクタと任意のDNSサーバーを指定する場合
.\checkdns.ps1 example.com google -s 1.1.1.1
```

## オプション引数

| 引数 | 説明 |
| :--- | :--- |
| `ドメイン名` | 確認したいドメイン名（必須） |
| `DKIMセレクタ名` | DKIMレコードを確認するためのセレクタ名（任意） |
| `-g` | Google Public DNS (8.8.8.8) を参照先として使用する |
| `-s <IP>` | 指定したIPアドレスのDNSサーバーを参照先として使用する |

## 注意点

- コマンドの依存関係:
    - `checkdns.sh` は `dig` コマンドが必要です。
    - `checkdns.ps1` は `Resolve-DnsName` コマンドを使用します。
- DKIMの確認:
    - DKIMレコードを確認するには、対象のドメインで使用されている「セレクタ名」を事前に知っている必要があります。指定しない場合はスキップされます。
- DNSの反映:
    - レコードを変更した直後は、参照するDNSサーバーによって古い情報が返ってくることがあります。最新の状態を確認したい場合は、`-g` オプションなどで外部のDNSを直接参照することをお勧めします。

## 参考リンク

https://zenn.dev/kwaka1208/articles/google-workspace-mail-settings
