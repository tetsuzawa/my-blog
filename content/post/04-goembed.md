---
title: "go embedでバイナリにシークレットを埋め込んでいいの？"
summary: "Go 1.16以降のシークレットの扱い方について実験してみました"
date: "2021-02-18"
auther: "admin"
tag: ["Go", "Golang", "Go116"]
category: ["tips"]

reading_time: false # Show estimated reading time?
share: true # Show social sharing links?
profile: true # Show author profile?
comments: true # Show comments?
toc: true # Show table of contents? true/false
feature: true
lastmod: true
publishDate: true

header:
  caption: "秋口の銀河庭園"
  image: "04/garden_compressed.png"
---

# Go1.16 リリース 👏🏻

Go 1.16 が[リリース](https://blog.golang.org/go1.16)されましたね。

このバージョンから embed package が追加されて[バイナリにファイルを埋め込むことができる](https://pkg.go.dev/embed)ようになりました。

<br>

<!-- textlint-disable -->

# シークレット情報埋め込んでもいいのかな？

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">go1.16でファイルをバイナリに含められるようになったけど、シークレットとかenvとかいれてもいいのかな</p>&mdash; てつ (@tetsuzawa_el) <a href="https://twitter.com/tetsuzawa_el/status/1362396328253251587?ref_src=twsrc%5Etfw">February 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ふっと思いました。

環境によってビルド方法を変えてバイナリにシークレット情報を埋め込んじゃえば運用が楽になるんじゃないかな？と。

AWS の SSM にシークレットを用意したりしなくていいし。

<!-- textlint-enable -->

<br>

# 実験してみました。

「シンプルなコードをコンパイルして、埋め込みありとなしで比較すればシークレットの中身が解析できそうかわかるかも」との予測のもと、実験してみました。

## コード

埋め込みなしのコード 👇。

```go
package main

import _ "embed"

var s string

func main() {
	print(s)
}
```

埋め込みありのコード 👇。

```go
package main

import _ "embed"

//go:embed hello.txt
var s string

func main() {
	print(s)
}
```

埋め込んだファイル(hello.txt)👇。
サイズは 35bytes です。

```txt:hello.txt
hello credentials xxxxxxxxxxxxxxxxx
```

<br>

<!-- textlint-disable -->

## コンパイル後のバイナリサイズ比較

サイズは同じになりました。（どゆこと？？？）

|               | 埋め込みなし | 埋め込みあり |
| ------------- | ------------ | ------------ |
| サイズ [byte] | 1,287,680    | 1,287,680    |

<!-- textlint-enable -->

<br>

## Hex Editor で中身を見てみた

よくわからなかったので[Hex Editor](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor)でバイナリの中身を見てみました。

バイナリの中身をのぞいていると、あっけなく hello.txt の中身が発見できちゃいました。

<!-- textlint-disable -->

{{< figure library="true" src="04/hex_editor.png" title="hello.txtの中身が見えている" width="90%" >}}


<br>

# 結論: 自身を持ってだめとは言えない

上の結果からわかるように、簡単に中身が解析できてしまうので、バイナリが配布するようなプロジェクトでは使えないでしょう。

ただ、非公開サーバーで動くプログラムならあながちありなのかなと思いました。シークレットファイルを別途管理する必要がなくなりますし、シングルバイナリの恩恵を享受しやすくなるのかなと思います。

<!-- textlint-enable -->

<br>

**考察あまりしてません。マサカリお待ちしてます。**