---
title: "hugo/academicを試してみた"
summary: "test投稿を兼ねてmarkdownの文法を確かめてみました"
date: "2020-08-16"
auther: "admin"
tag: ["hugo", "academic"]
category: ["hugo"]

reading_time: false  # Show estimated reading time?
share: true  # Show social sharing links?
profile: true # Show author profile?
comments: true  # Show comments?
feature: true
lastmod: true
publishDate: true

header:
  caption: "育ててるサボテン"
  image: "cactus.jpg"
---

前々から技術ブログを作りたいと思っていたのでhugoで作って見ました。

themeはどうしようか迷ったんですが、とりあえずランキングで1位になっていたacademicを使っています。

テストがてらMarkdownの基本文法を試してみます。

# #見出し1
## ##見出し2
### ###見出し3
#### ####見出し4
##### #####見出し5

**強調**、~~打ち消し~~、<details><summary>折りたたみ</summary><div>

Goのやつです。

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, 世界")
}
```
</div></details>

<br>
<br>
<br>


<!-- textlint-disable -->
\```go:hello_world/main.go

package main

import "fmt"

func main() {
    fmt.Println("Hello, 世界")
}

\```
<!-- textlint-enable -->

こうすると次のようになります。


```go:hello_world/main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, 世界")
}
```


codeブロックはQiitaみたいにファイル名を表示させられないみたいです。

hugoのacademicはsyntax highlightのテーマを変えられたり、カスタマイズ性が高いのでおもしろいです。

これから気になったことを書いていきます。

