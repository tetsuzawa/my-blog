---
title: "さくっとURL一覧を確認できる静的解析ツールを作った。"
summary: "ISUCONに向けてURL一覧を確認できる静的解析ツール listrouteを作りました。"
date: "2022-09-19"
auther: "admin"
tag: ["tech", "static analysis", "Go", "ISUCON"]
category: ["tech"]

reading_time: false # Show estimated reading time?
share: true # Show social sharing links?
profile: true # Show author profile?
comments: true # Show comments?
toc: true # Show table of contents? true/false
feature: true
lastmod: true
publishDate: true
---

{{< figure library="true" src="09/dstat.png" title="" width="80%">}}

> ※ 「ISUCON」は、LINE株式会社の商標または登録商標です。

ISUCON12で見事に敗北したたきです。

最近悔しさのあまり来年に向けてISUCONの素振りをよくしています。

ISUCONが始まるとまず当日マニュアルを読んで仕様や制約を把握するのが重要です。
当日マニュアルには一部のパスに対してx秒情報反映の猶予があるよーとか、429 Too Many Requstsを返していいよーとか、クライアントキャッシュ使ってもいいよーって情報が書かれていることがあります。
これらはスコアアップのヒントになってることが多いです。

なので集中して読み込む必要があるんですが、素振りを重ねるごとに自分はパスやハンドラの一覧が無いと情報が入って来づらいことに気づきました。

じゃあ一覧をいい感じに出してしまおうということで listroute というツールを作りました。

<br> 

# listroute

https://github.com/tetsuzawa/listroute

Goファイルの中から `e.GET("/", RouteHandler)` などといったルーティング情報を探してきて表示してくれるツールです。

grep でも似たようなことはできるんですが、シェル芸人や正規表現芸人になる必要があったりして大変です。（慣れてれば問題ないのかも

listrouteを実行するにはGo環境が必要ですが、静的解析ツールなのでコメントのノイズなどを考える必要がなくなります。
また、関数呼び出しが複数行になっていても問題なく探し出してくれます。


## 例

こんな感じのGoファイルがあるとします。

```go
package main

import (
  "github.com/labstack/echo/v4"
)

func main() {
  e := echo.New()

  e.GET("/", GETHandler)
  e.POST("/", POSTHandler)
  e.PUT("/", PUTHandler)
  e.DELETE("/", DELETEHandler)
  e.PATCH("/", PATCHHandler)
  e.Static("/foo.jpg", "/public")
  e.File("/bar", "/bar.txt")
  e.GET(
    "/foo/bar",
    GETHandler2,
  )
}

func GETHandler(c echo.Context) error    { return nil }
func POSTHandler(c echo.Context) error   { return nil }
func PUTHandler(c echo.Context) error    { return nil }
func DELETEHandler(c echo.Context) error { return nil }
func PATCHHandler(c echo.Context) error  { return nil }
func GETHandler2(c echo.Context) error   { return nil }

```

これに対して listrouteを実行します。（vettoolを使うときは絶対パスを指定しないといけないことに注意）

```shell
go vet -vettool=`which listroute` ./...
```

するとこんな感じで一覧が得られます。


```text
./main.go:10:2: e.GET("/", GETHandler)
./main.go:11:2: e.POST("/", POSTHandler)
./main.go:12:2: e.PUT("/", PUTHandler)
./main.go:13:2: e.DELETE("/", DELETEHandler)
./main.go:14:2: e.PATCH("/", PATCHHandler)
./main.go:15:2: e.Static("/foo.jpg", "/public")
./main.go:16:2: e.File("/bar", "/bar.txt")
./main.go:17:2: e.GET(
	"/foo/bar",
	GETHandler2,
)
```



ISUCONのように巨大な単一ファイルからパスとハンドラ名を一緒に取ってきてくれるのは割と便利なんじゃないでしょうか。


## オプション

```
-listroute.matcherFunctions <list of functions>
```

を指定することで検索対象の関数名を変えられます。

関数名はカンマ区切りで複数指定可能です。大文字小文字は区別します。

デフォルトでは[labstack/echo/v4](https://github.com/labstack/echo) の関数群に対応してます。 (`GET,POST,PUT,DELETE,PATCH,Static,File,Group`)

指定例

```
go vet -vettool=(which listroute) -listroute.matcherFunctions=Get,Post,Handle
```


## インストール方法


[README](https://github.com/tetsuzawa/listroute) を見てくださいmm

go install と バイナリリリースに対応してます。



## おわりに

pkg名を参照したりしてないのは単純にさぼってるからです。（無駄な最適化をするよりかは汎用性高くていいかも？）

すごくシンプルなのでルーティング以外にも使えちゃうかもです。

DB系の`Exec`とか`Query`とか。

来年は勝ちたい。
