---
title: "メルカリのOnline Summer Internship for Gophers 2020に参加してきた"
summary: "メルカリのサマーインターンで静的解析ツールを作って来ました"
date: "2020-09-29"
auther: "admin"
tag: ["Mercari", "Internship"]
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
  image: "03/mercari_intern.png"
---

# Online Summer Internship for Gophers 2020について

[Online Summer Internship for Gophers 2020](https://mercan.mercari.com/articles/22800/)はメルカリで実施されたサマーインターンシップです。期間は8/31~9/4までの平日5日間でした。募集人数は20名とありましたが、実際は30名ほど参加していたようです（確認してません）。

参加者はTwitterや技術ブログで見たことがある人や、言語処理系に明るい人など強い人がとても多かったです。

<br>

# 内容 

このインターンシップはよくあるWeb開発のインターンシップとは異なり、Goの静的解析に特化した技術色の強いコンテンツでした。

前半に[プログラミング言語Go完全入門](https://engineering.mercari.com/blog/entry/goforbeginners/)の14章をもとにGoの静的解析に関する周辺知識を学び、後半は、静的解析ツール・その周辺ツールの開発を行いました。

静的解析でできることや利点は[プログラミング言語Go完全入門](https://engineering.mercari.com/blog/entry/goforbeginners/)を参考していただくと良いと思います。

<br>

# 制作物

僕が制作したのは[ruleanalyzer](https://github.com/tetsuzawa/ruleanalyzer)というコード生成ツールです。

Goで開発をしていると次のようなシチュエーションに出会うことがあると思います。

- `xxx.Open()`したものを`Close()`し忘れる
- 独自に開発したライブラリをチームで共有するときに関数呼び出しの順番などといった使い方をいちいちレビューするのが面倒

`ruleanalyzer`はこれらの問題を解決できると考えています。


## 使い方

Goの静的解析ツールは`unitchecker`と`analysis.Analyzer`を使うことで`go vet -vettool=$(which myvet) pkgname`から呼び出すことができます。

`ruleanalyzer`はこの仕組みで呼び出すことを前提としています。

### 0. インストール

事前に`ruleanalyzer`をインストールしておいてください。

```shell

$ go get -u https://github.com/tetsuzawa/ruleanalyzer/cmd/ruleanalyzer

```


### 1. ルールを記述したgoファイルを_ruleディレクトリに作る

まず、

```go
func RuleOsOpen() {
    // step: call os.Open
    f, _ := os.Open("xxx")
    // step: call *File.close
    defer f.Close()
}
```

のようにルールを記述したファイルを`_rule`以下に作ります（コンパイルに含まれなければどこでもいいです）。

### 2. ruleanalyzerを実行する

作成したルールに対して`ruleanalyzer`を実行します。

```
ruleanalyzer osopen_rule.go
```

正常に実行完了するとカレントディレクトリ以下にルール名のディレクトリ作成され、中に静的解析で使用するAnalyzerが生成されます。

```go
var Analyzer = &analysis.Analyzer{
    Name: "OsOpen",
    Doc:  doc,
    Run:  run,
    Requires: []*analysis.Analyzer{
       buildssa.Analyzer,
    },
}

func run(pass *analysis.Pass) (interface{}, error) {
   /* ...*/
```

### 3. main関数を書く

同ディレクトリにcmdディレクトリを切ってmain関数を書き、コンパイルします。

main関数でやることは、`unitchecker.Main`の引数に先程作成したAnalyzerを指定するだけです。

```go

package main

import (
	"ruleosopen"
	"golang.org/x/tools/go/analysis/unitchecker"
)

func main() { unitchecker.Main(ruleosopen.Analyzer) }

```

```shell

$ go build -o ruleosopen .

```



### 4. go vet から呼び出す

最後にgo vetで作成した静的解析ツールを呼び出します。

```shell

$ go vet -vettool=./ruleosopen pkgname

```

使い方は以上になります。

## ルールのフォーマット


- 関数名は`RuleXxx`のように`Rule`で始めます
- 各ステップの処理を次のフォーマットのコメントの次の行に書きます   
  `// step: xxxxxxx`
- コメントの後に複数行の処理を書いても必要なステップとして認識されるのは直後の行のみです

## ruleanalyzerの原理

簡単にですが`ruleanalyzer`の原理を書いておきます。


1. ルール解析
  1. ルールが記述された関数をSSA形式（静的単一代入形式）に変換する
  1. 特定フォーマットのコメント直後の命令から`*types.Object`を取り出し、`MilestoneQueue`に追加する
1. コード生成
  1. `*types.Object`からパッケージ名、型名、オブジェクト名などを取得する
  1. これらの情報を元にAnalyzer内でオブジェクトを再取得するコードを構築する
  1. テンプレートを使用し、ソースコードを組み立てる

以上の流れで`ruleanalyzer`は動いています。


## TODO

- 対応する命令を増やす  
    現状、`*ssa.Call`、`*ssa.Alloc`、`*ssa.Defer`のみしか命令を処理できていないため、宣言をはじめとする他の命令にも対応したいです。
- 各ステップで作られた変数を追従し、その後のステップと結びつけられるようにする  
    現状、変数と関数呼び出しなどの対応付けができていない状態である。元のコードのSSA形式の構造を生成したAnalyzerに持ち込む方法を思いついていないので考えたいです。
- インターフェースのメソッド呼び出しに対応する  
    インターフェースからの呼び出しはポインタ解析が必要となり、現状対応できていません。  
- コードのリファクタ  
    時間が限られていたためパッケージ構成やファイル分けが雑になってしまっている。また、テストも書けていないため追加したいです。

<br>

# おわりに

このインターン参加者は本当に強い人が多かったです。後半は他の方々がどんどん開発を進めている中、自分はなかなか進捗が生まれずかなり焦りましたが、なんとか動くものを作れてよかったです。

今後も[`ruleanalyzer`](https://github.com/tetsuzawa/ruleanalyzer)は少しずつ開発する予定なのでスターをつけてくれると喜びます。

インターンの所感としては、参加者は多様性に富み、技術面では簡単にはたどり着けないようなGoの領域について学べたため、さすがメルカリという感じでした。

静的解析については初心者でしたが体系的に知識を得られたため、エンジニアとして幅が広がったような気がします。

来年度も同じテーマになるかはわかりませんが、静的解析に興味があれば是非応募してみると良いと思います。