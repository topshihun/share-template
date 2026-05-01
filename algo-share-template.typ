// ============================================================
//  algo-share-template.typ — 算法 / 题解分享模板
//
//  License: MIT — Copyright (c) 2025 topshihun <topshihun@qq.com>
//
//  用法：
//    #import "algo-share-template.typ": *
//    #show: doc.with(title: "标题", author: "作者", date: datetime.today())
//
//  组件：tip, warn, info, complexity-tab, code-block, steps,
//        algo-steps, testcase, ref-card
// ============================================================

// ── 颜色（清爽理性系） ──
#let c1 = rgb("#1B3A5C")  // 主色：深蓝黑
#let c2 = rgb("#2E86C1")  // 强调：亮蓝
#let c3 = rgb("#2471A3")  // h2
#let c4 = rgb("#2E7DB5")  // h3
#let cbg = rgb("#F4F7FA")  // 代码块背景
#let cbd = rgb("#C8D6E5")  // 代码块边框
#let cib = rgb("#EBF0F5")  // 行内背景
#let cif = rgb("#C0392B")  // 行内前景
#let ctb = rgb("#EEF5FC")  // tip 背景
#let ctl = rgb("#3498DB")  // tip 左边框
#let ctt = rgb("#2471A3")  // tip 标题色
#let ctc = rgb("#2C3E50")  // tip 正文色
#let ch = rgb("#8DA8C0")  // 页眉
#let cf = rgb("#A0B8D0")  // 页脚
#let cgold = rgb("#D4A017")  // 金牌色（用于最优解标记）

// ── 字体 ──
#let fm = ("Source Han Sans", "Times New Roman", "SimSun")
#let fc = ("JetBrainsMono NFM", "Consolas", "DejaVu Sans Mono")

// ═══════════════════════════════════════════════
//  主函数
// ═══════════════════════════════════════════════

#let doc(title: "算法分享", author: none, date: none, tags: (), body) = {
  set page(paper: "a4", margin: (top: 2.4cm, bottom: 2.2cm, left: 2.4cm, right: 2.4cm), numbering: "1")
  set text(font: fm, size: 11pt, lang: "zh")
  set par(justify: true, leading: 0.7em, first-line-indent: 0pt)
  set heading(numbering: "1.1")

  // 一级标题：居中 + 细线
  show heading.where(level: 1): it => block(width: 100%, breakable: false, above: 1.8em, below: 1em)[
    #set align(center)
    #line(length: 30%, stroke: 0.8pt + c2)
    #v(0.4em)
    #text(20pt, weight: "bold", fill: c1)[#it.body]
    #v(0.4em)
    #line(length: 30%, stroke: 0.8pt + c2)
  ]

  // 二级标题：左侧细色条 + 编号前缀
  show heading.where(level: 2): it => {
    set block(above: 1.2em, below: 0.5em)
    text(14pt, weight: "bold", fill: c3)[#box(width: 3.5pt, height: 1em, fill: c2) #h(6pt) #it.body]
  }

  // 三级标题
  show heading.where(level: 3): it => {
    set block(above: 0.9em, below: 0.3em)
    text(12pt, weight: "bold", fill: c4)[#it.body]
  }

  // 代码块
  show raw: set text(font: fc, size: 9pt)
  show raw.where(block: true): it => {
    set block(above: 0.5em, below: 0.6em)
    block(fill: cbg, stroke: 0.6pt + cbd, inset: 10pt, radius: 3pt, width: 100%, breakable: true)[
      #set par(first-line-indent: 0pt)
      #it
    ]
  }
  show raw.where(block: false): it => box(fill: cib, inset: (x: 3pt, y: 1pt), radius: 2pt)[
    #text(fill: cif)[#it]
  ]

  // 页眉页脚
  set page(
    header: context {
      if counter(page).get().first() != 1 {
        set text(9pt, fill: ch)
        line(length: 100%, stroke: 0.4pt + rgb("#CCD5E0"))
        v(4pt)
        grid(
          columns: (1fr, 1fr),
          [#title], align(right)[第 #counter(page).display() 页],
        )
      }
    },
    footer: context {
      if counter(page).get().first() != 1 {
        set text(8pt, fill: cf)
        align(center)[—— 欢迎讨论 · 转载注明出处 ——]
      }
    },
  )

  // 封面：居中
  block(width: 100%, above: 4em, below: 2em)[
    #set align(center)
    #text(26pt, weight: "bold", fill: c1)[#title]
    #v(0.6em)
    #line(length: 15%, stroke: 1pt + c2)
    #v(0.6em)
    #if author != none { text(13pt, fill: rgb("#555555"))[#author] }
    #if date != none { text(11pt, fill: rgb("#888888"))[#if author != none { [ · ] }#date] }
    #if tags.pos().len() > 0 {
      v(0.8em)
      text(9.5pt, fill: c2)[#for tag in tags.pos() {
        [#box(fill: rgb("#E8F0F8"), inset: (x: 6pt, y: 2pt), radius: 3pt)[#tag] #h(4pt)]
      }]
    }
  ]

  body
}

// ═══════════════════════════════════════════════
//  语义组件
// ═══════════════════════════════════════════════

// callout 底座
#let callout(icon: none, title: none, body: none, fill: ctb, border-color: ctl, title-color: ctt, body-color: ctc) = {
  block(
    above: 0.6em,
    below: 0.6em,
    fill: fill,
    stroke: (left: 3.5pt + border-color),
    inset: (x: 12pt, y: 8pt),
    radius: 3pt,
    width: 100%,
  )[
    #text(10.5pt, weight: "bold", fill: title-color)[#if icon != none { [#icon ] }#if title != none { [#title] }]
    #v(4pt)
    #text(10pt, fill: body-color)[#set par(first-line-indent: 0pt); #body]
  ]
}

// 三种语义色
#let tip(title, body) = callout(icon: "💡", title: title, body: body, fill: ctb, border-color: ctl, title-color: ctt)
#let warn(title, body) = callout(
  icon: "⚠️",
  title: title,
  body: body,
  fill: rgb("#FFF8E1"),
  border-color: rgb("#F39C12"),
  title-color: rgb("#E67E22"),
)
#let info(title, body) = callout(
  icon: "ℹ️",
  title: title,
  body: body,
  fill: rgb("#E8F8F5"),
  border-color: rgb("#27AE60"),
  title-color: rgb("#1E8449"),
)

// complexity-tab：复杂度表格
#let complexity-tab(time: "—", space: "—", extra: none) = {
  block(above: 0.5em, below: 0.5em)[
    #set align(center)
    #block(fill: rgb("#F8FAFC"), stroke: 0.5pt + cbd, inset: 10pt, radius: 4pt)[
      #set par(first-line-indent: 0pt)
      #text(10.5pt, weight: "bold", fill: c3)[⚙ 复杂度分析]
      #v(5pt)
      #grid(
        columns: (1fr, 1fr),
        gutter: 8pt,
        [
          #text(9.5pt, fill: rgb("#7F8C8D"))[时间复杂度]
          #v(2pt)
          #text(11pt, weight: "bold", fill: c1)[#time]
        ],
        [
          #text(9.5pt, fill: rgb("#7F8C8D"))[空间复杂度]
          #v(2pt)
          #text(11pt, weight: "bold", fill: c1)[#space]
        ],
      )
      #if extra != none {
        v(4pt)
        text(9pt, fill: rgb("#7F8C8D"))[#extra]
      }
    ]
  ]
}

// code-block：带语言标签的代码块
#let code-block(lang: "plain", body) = {
  block(above: 0.5em, below: 0.6em)[
    #block(
      fill: cbg,
      stroke: 0.6pt + cbd,
      inset: (x: 0pt, y: 0pt),
      radius: 3pt,
      width: 100%,
      breakable: true,
    )[
      // 顶部标签栏
      #block(
        fill: rgb("#DCE6F0"),
        inset: (x: 10pt, y: 3pt),
      )[
        #set par(first-line-indent: 0pt)
        #text(8.5pt, fill: c3)[#lang]
      ]
      // 代码内容
      #block(inset: (x: 10pt, y: 6pt))[
        #set par(first-line-indent: 0pt)
        #set text(font: fc, size: 9pt)
        #body
      ]
    ]
  ]
}

// steps：步骤列表
#let steps(..items) = {
  block(inset: (left: 0.5em, top: 0.3em, bottom: 0.3em))[
    #set par(first-line-indent: 0pt)
    #for (i, item) in items.pos().enumerate() {
      [#text(fill: c2)[#box(circle(width: 1.2em, height: 1.2em, fill: rgb("#E8F0F8")), align(center, text(9pt, weight: "bold", fill: c2)[#(i + 1)]))] #h(6pt) #item]
      if i < items.pos().len() - 1 { v(0.35em) }
    }
  ]
}

// algo-steps：算法流程步骤（更紧凑的编号列表）
#let algo-steps(..items) = {
  block(inset: (left: 0.5em, top: 0.3em, bottom: 0.3em))[
    #set par(first-line-indent: 0pt)
    #for (i, item) in items.pos().enumerate() {
      [#{ i + 1 }. #item]
      if i < items.pos().len() - 1 { v(0.2em) }
    }
  ]
}

// testcase：测试用例展示
#let testcase(input, output, explanation: none) = {
  block(
    above: 0.5em,
    below: 0.5em,
    fill: rgb("#FAFBFC"),
    stroke: 0.5pt + cbd,
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    width: 100%,
  )[
    #set par(first-line-indent: 0pt)
    #text(10pt, weight: "bold", fill: c3)[📋 示例]
    #v(4pt)
    #text(9.5pt, fill: rgb("#7F8C8D"))[输入：] #text(9.5pt, fill: ctc)[#input]
    #v(2pt)
    #text(9.5pt, fill: rgb("#7F8C8D"))[输出：] #text(9.5pt, fill: ctc)[#output]
    #if explanation != none {
      v(2pt)
      #text(9.5pt, fill: rgb("#7F8C8D"))[解释：] #text(9.5pt, fill: ctc)[#explanation]
    }
  ]
}

// ref-card：相关题目/参考卡片
#let ref-card(..items) = {
  block(
    above: 0.6em,
    below: 0.6em,
    fill: rgb("#F8FAFC"),
    stroke: 0.5pt + rgb("#DCE6F0"),
    inset: 12pt,
    radius: 4pt,
    width: 100%,
  )[
    #set par(first-line-indent: 0pt)
    #text(10.5pt, weight: "bold", fill: c3)[🔗 相关题目]
    #v(5pt)
    #for item in items.pos() {
      [#item]
      v(2pt)
    }
  ]
}
