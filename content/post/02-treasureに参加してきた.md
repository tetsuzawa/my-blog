---
title: "VOYAGE GROUPのインターン、Treasureで最高の経験をしてきた"
summary: "株式会社VOYAGE GROUPが主催しているTreasureに参加してきたので内容と感想を書きます"
date: "2020-08-31"
auther: "admin"
tag: ["VOYAGE GROUP", "Treasure", "Internship"]
category: ["Internship"]

reading_time: false  # Show estimated reading time?
share: true  # Show social sharing links?
profile: true # Show author profile?
comments: true  # Show comments?
toc: true  # Show table of contents? true/false
feature: true
lastmod: true
publishDate: true

header:
#   caption: ""
  image: "treasure-hero.jpg"
---


<!-- textlint-disable -->
# Treasure is 何?

Treasureは[株式会社VOYAGE GROUP](https://voyagegroup.com/)が実施している夏季インターンシップです。

例年3週間で開催されているようですが、今年はCovid−19の影響で事前の土日の講義3日間+平日のチーム開発2週間という日程でした。

VOYAGE GROUPのオフィス「SHIP」は寝転がれるスペースやバーを有しており非常におしゃれなのですが、今回は完全オンラインでの開催でした（めっちゃいきたかった...）。

<!-- textlint-disable -->

{{< figure library="true" src="AJITO_1.png" title="社内バー「AJITO」" width="80%" >}}


{{< figure library="true" src="BEACH.png" title="図書館「OASIS」と横になれるスペース「BEACH」" width="80%" >}}
<!-- textlint-enable -->

# 応募したきっかけ


自分はもともと非情報系でWeb関連も独学で勉強してきたことから、同世代に技術レベルがまったくわかっていない状態でした。

勉強法もQiitaや技術ブログ、Udemyなどを利用して散り散りの知識をかき集めながらコードを書いてみるというもので、自分が書くコードに自信もあまり持ていませんでした。

このような背景から、とにかく一度インターンに参加して実務経験を得なければいけないと考えていました。これが2020年2月あたりです。

ちょうどそのとき[athletics](https://athletix.run/)というサービスでVOYAGE GROUPの「CTOからの挑戦」というコーディングチャレンジのイベントが開催されているのを知り、この会社に興味を持ちました。というのも、当時の自分は「エンジニアとして働くなら技術力を評価されたい」と思っており、このようなイベントを開くからには社内でも技術力が重視されているに違いないと考えたからです。

そこでインターンを開催してないか調べたところ、タイミング良くTreasureの募集が開始されていたので応募した次第です。

また、使用言語がGoということで、Web関連ではGoが一番得意な自分にとって好都合だったのも理由の1つです。

<br>
<br>

# 内容

## 前半

前半の講義は次の項目について行われました。

- フロントエンド
- バックエンド
- データベース
- インフラ
- アイデア

おわかりのように、Web開発に必要な知識を一通り学ぶことができます。

習ったことをすべて書きたいところですが、ボリュームがえげつないことになるので（まじで）、各講義で特にためになったことを書いていきます。

> ちなみに初日の講義が始まる前にTreasure Tシャツとお菓子がたくさん送られて来ました。
> お菓子ボックスに米と缶詰が入っているのは笑いました
> {{< figure library="true" src="box_1.jpg" title="" width="80%">}}



### フロントエンド講義

フロントエンドの講義はまずJavaScriptの歴史の変遷から始まり、近年のツールやフレームワーク周りの関係性を体系的に教えてもらいました。

その後は`event-loop`、ブラウザの`WebAPI`、`promiss/async/await`や`function/arrow関数`などのJSではまりやすいポイントの説明をま見えながら演習しました。

基礎的な内容が多めな印象でしたが、フロントには苦手意識があり、あまり触ってこなかった自分にとっては初耳なものばかりで焦りました。しかし、このあたりの知識をさらえたことで苦手意識をかなり薄めることができました。

### バックエンド講義

バックエンド講義は全2回行われました。

1回目は次の説明が行われました。

- Goのテスト駆動開発・テーブル駆動テスト
- HTTPのendpoint設計について（RESTの思想）
- DBのmigration・transaction
- OAuthによる認証・認可

 
特におもしろかったのがRESTの思想を反映させたendpoint設計をTreasure生で議論した点です。このような議論は独学では絶対に経験できず、インターンならではの経験になりました。

DBのmigrationやtransactionについては今まで意識したことがなくDB周りの経験の足りなさを実感しました。

内容が濃い上に演習を挟んでいたので、Goが得意でなければかなり苦労しそうでした（それだけ学べることが多い）。


2回目は主にWebSocket・WebRTCに関する講義でした。MDNを読みながらブラウザのAPIを操作してP2Pでビデオ通話をできるような実装をしましたが、正直かなり難しいように感じました。

これに関しては講義を聞いていたフロントの講師の方も「これができたらSkyWayに就職できるんじゃない」と言っていたのでそこそこレベルの高いことをやっていたようです。

### データベース講義

前半の講義の中でも一番よい経験ができたと思っているのがこのデータベース講義です。

流れ的には前半に分離レベル、制約、正規化などデータベース設計の基本を習い、後半にこれらを意識しながら複数人でチームとなりデータモデリングの実践をしました。

データモデリングではベースのスキーマが与えられていて、「"xxx"の情報も入れたい」などのお題に合わせて追加でテーブルの設計をしていきました。

RDBは後から構造を変えるのが容易ではないため、初期段階での汎用性、拡張性が重要となります。そのため、想像力を最大限に働かせて設計する必要があります。

実際に講義では、自分がこの設計で良さそうと思ったタイミングで、チームメンバーから「このカラムも必要だよね」などのアイデアが出たりしました。
このように議論によって設計が何度も修正されていく体験はとても貴重で、チーム開発の強みを実感しました。

<!-- textlint-disable -->
{{< figure library="true" src="dbdiagram.png" title="データモデリングの様子" >}}
<!-- textlint-enable -->

### インフラ講義

インフラ講義ではDevOpsやCI/CDに関する説明とTreasureでベースとして与えられたアプリケーションのインフラの構成を確認しました。

ここで参考になったのはAWSの各サービスのインスタンスから吐かれるログをCloudWatch LogsからNewRelicという外部サービスに横流して監視するというものです。

今まで個人で作っていたアプリケーションではインスタンスのログページを直接見に行ったりしていて煩わしく思っていたので、今後は自分で作るものにも取り入れるつもりです。


### アイデア講義

アイデア講義では、時流・ユーザー・社会のゆらぎからUNS（User・Needs・Solution）を考え、プロダクトになりうるアイデアをひねり出すということを行いました。

<!-- textlint-disable -->
今まではアイデアが出るタイミングは

- 天才的なひらめきを持っている人が思い付く
- 何かに対して強い情熱を持っている人が思い付く
- 日常のまぐれ

くらいしかないと思ってた自分ですが、アイデア出しにもフレームワークがあり、能動的に探すことができるということに気が付きました。

{{< figure library="true" src="idea_work.png" title="アイデアワーク" width="80%">}}
<!-- textlint-enable -->

<br>
<br>

## 後半

後半はTreasureのメインコンテンツであるチーム開発が行われました。

期間は2週間弱で、形式は1チーム4人で与えられたお題の中から1つ選んでプロダクト作るというハッカソンでした。

<!-- textlint-disable -->
先に結果を書くと、「SlimLine」というサービスを開発して見事グランプリを取ることができました！また、UI/UX賞・アイデア賞もいただくことができ、3冠でTreasureを終えることができました。
<!-- textlint-enable -->

{{< figure library="true" src="slimline.png" width="80%">}}

チーム開発のパートでも学びはたくさんありましたが、その中でも特に響いたことを書きます。


### MVPを徹底的に意識する


MVP (Minimum Viable Product) 意識することは本当に大事です。最低限サービスとして必要な機能を決定する柱になるからです。

自分たちのチームでは、アイデア出しに予定よりもかなり多くの時間を割いてMVPをひねり出しました。

<!-- textlint-disable -->
中間発表のときには「実装予定の機能が多すぎないか」・「時間が足りなくて実装しきれないのではないか」という趣旨のレビューをいただいていましたが、その後にサポーターの方々からのアドバイスを参考にMVPを修正し、最終的にすべての機能を実装し終えることができました。

残り時間が少ない中、実装を完了させることができたのはチーム内でMVPを共有することで周り道をすることなく開発を進められたためです。

また、Treasure期間中は意識する余裕がありませんでしたが、MVPはUI/UXやデザインなどを決定するときの判断基準になりえると思うので、今後は徹底的に意識していきたいです。

<!-- textlint-enable -->

### 開発段階の分割方法について

これは、サービスを開発するときの分割方法を次のどちらにするかという話です。

<!-- textlint-disable -->
{{< figure library="true" src="incrementing.jpg" title="" width="80%">}}

{{< figure library="true" src="iterating.jpg" title="（出展：[Jeff Patton/Don’t Know What I Want, But I Know How to Get It](https://www.jpattonassociates.com/dont_know_what_i_want/)）" width="80%">}}
<!-- textlint-enable -->

前者の開発方法では、部品がすべてそろわないとリリースできないというリスクがあります。さらに、つなぎ合わせの段階になって始めてうまく動かないということが起きたり、必要のない機能・必要なのに足りない機能が顕わになったりする可能性があります。

一方、後者では各部品は未完成ながらもエンドツーエンドで動作するので、リリース自体は早期からすることが可能となります。また、機能の不備などといった前者の問題点にも気付きやすいです。

自分は意識せず前者の方法で開発を進めてしまっていましたが、サポーターの方の御指摘によって途中から後者を意識して開発を進めることができました。

思い返すと、自分はもともとWeb開発に限らず前者の方法で物事を進める癖があったので、ここで気付かせていただけたのは非常にありがたかったです。


<br>
<br>


# Treasureを終えて

<!-- textlint-disable -->
インターンシップにここまでリソースを割いてくれるのは素直にすごいと感じました。
> CTOの小賀さんも、「社員が一年で一番忙しくなるのがTreasure期間だと思う」とおっしゃっていました
<!-- textlint-enable -->

チーム開発中はアイデア出しの時間が長く続き「全然エンジニアなことができてない」と思っていましたが、逆にこういった仕事もこなしていくのがVOYAGE GROUPのエンジニアで、文化なのだと感じました。

Web開発の基礎から濃厚なチーム開発まで経験でき、文字通り圧倒的な成長をできるので気になる方は絶対に応募した方がよいです。

講師・サポーターを含めたTreasure参加者の交流や期間中にいただいた[#voyagebook](https://techlog.voyagegroup.com/entry/engineers-in-voyage)についても触れたかったですが、長くなるのでここまでにします。

9/26日にサポーターズ主催の[技育展](https://talent.supporterz.jp/geekten/2020/)で登壇し、SlimLineについて発表する予定なので見てくれるとうれしいです。
