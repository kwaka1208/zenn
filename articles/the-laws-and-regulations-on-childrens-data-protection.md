---
title: 世界の子どものデータ保護に関する法律・規則
emoji: "👩🏻"
type: idea
topics: [法律, GDPR, COPPA, プライバシー, データ保護]
published: false
---
オンラインサービスの利用において、13歳以上もしくは16歳以上であることが利用規約に定められていることがありますが、それらが定められている要因のひとつとなっている法律や規則があります。これらを知っておくと年齢制限の理由が理解しやすいと思いますのでまとめておきます。

だいたい、COPPAかGDPRが基準になってます（全部がそうであるとは限りません、国ごとに定められているものもあります）。

## COPPA（Children's Online Privacy Protection Act）
児童オンラインプライバシー保護法と呼ばれるアメリカの法律で13歳未満の子どもに対して、個人情報の提供を伴うサービスを提供する場合、保護者の確認（一回だけじゃなくて都度）が必要になるということを定めています。

この法律に則っていれば13歳未満にでも個人情報の提供を伴うサービスを提供してもいいのですが、仕組みとしてとても複雑になるし利用者としても面倒なことになる（一々保護者の確認が必要になる）ので、実質的に13歳未満への個人情報の提供を伴うサービスの提供を制限する法律になっています。2000年から効力を発揮しています。

### 参考リンク
- [Children's Online Privacy Protection Act](https://en.wikipedia.org/wiki/Children's_Online_Privacy_Protection_Act)
- [子ども向けアプリに関するポリシー（COPPA） | ポリシーセンター](https://developer.amazon.com/ja/docs/policy-center/privacy-children.html)

## GDPR（General Data Protection Regulation）
EU一般データ保護規則と呼ばれるEUとイギリスの規則で、年齢に関係なくEU（とイギリス）の域内の個人データの保護に関する規則です。
このGDPRの一部で子ども向けの規則を定めたGDPR-Kでは、16歳未満（国によって独自に年齢を設定している場合もあります）については個人データの提供に関して保護者の同意が必要となることを定めています。GDPRは、2016年に制定されています。

### 参考リンク
- [EU一般データ保護規則](https://ja.wikipedia.org/wiki/EU一般データ保護規則)
- [EU 一般データ保護規則（GDPR）について | EU - 欧州 - 国・地域別に見る - ジェトロ](https://www.jetro.go.jp/world/europe/eu/gdpr/)
- [GDPR（EU一般データ保護規則）とは？解説と対策](https://www.manageengine.jp/solutions/gdpr/lp/)

## 事例
COPPAの事例はあまり見ないのですが、GDPR関連でいくつかピックアップしておきます。

### Scratchのアカウント作成ができるのは16歳以上
Scratchアカウントを作成できる年齢は当初13歳以上でしたが、途中から16歳以上に引き上げられれています。
[プログラミングサポートページ | 子供の科学★ミライサイエンス](https://www.kodomonokagaku.com/miraiscience/support/index.html)

### Yahoo! JAPANはEU域内では利用不可
2022年からEU域内とイギリスからはYahoo! JAPANが一部を除いて利用できなくなっていますが、これはGDPRへの対策にコストがかかりすぎるためです。
[重要なお知らせ - Yahoo! JAPAN](https://privacy.yahoo.co.jp/notice/globalaccess.html)

### GDPR違反で多額の制裁金
GDPR違反をすると多額の制裁金が課せられることがたびたびニュースになっています。
- [GDPR違反でグーグルに62億円の制裁金、フランス当局の判断理由から日本企業が学ぶべきこと - BUSINESS LAWYERS](https://www.businesslawyers.jp/articles/530)
他にもよく知られた企業が課せられています。
- [GDPR罰金まとめ（2023年1月時点）](https://acompany.tech/privacytechlab/gdpr-fine/)