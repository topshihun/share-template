// ============================================================
//  tech-share-template.typ — 通用科技分享模板
//
//  License: MIT — Copyright (c) 2025 topshihun <topshihun@qq.com>
//
//  用法：
//    #import "tech-share-template.typ": *
//    #show: doc.with(title: "标题", author: "作者", date: datetime.today())
//
//  组件：tip, warn, info, col-list, cmds-table, data-table, steps
// ============================================================

// ── 颜色 ──
#let c1 = rgb("#1A3C6E")  // 主色
#let c2 = rgb("#3B7DD8")  // 强调
#let c3 = rgb("#2C5F8A")  // h2
#let c4 = rgb("#3A6B9F")  // h3
#let cbg = rgb("#F5F6FA")  // 代码块背景
#let cbd = rgb("#D0D5E0")  // 代码块边框
#let cib = rgb("#EDF0F5")  // 行内代码背景
#let cif = rgb("#C7254E")  // 行内代码前景
#let ctb = rgb("#EBF5FB")  // tip 背景
#let ctl = rgb("#3498DB")  // tip 左边框
#let ctt = rgb("#2980B9")  // tip 标题色
#let ctc = rgb("#2C3E50")  // tip 正文色
#let ch = rgb("#8899AA")  // 页眉
#let cf = rgb("#A0B0C0")  // 页脚
#let cta = rgb("#FAFBFC")  // 速查表背景

// ── 字体 ──
#let fm = ("Source Han Sans", "Times New Roman", "SimSun")
#let fc = ("JetBrainsMono NFM", "Consolas", "DejaVu Sans Mono")

// ═══════════════════════════════════════════════
//  主函数
// ═══════════════════════════════════════════════

#let doc(title: "技术分享", author: none, date: none, body) = {
  set page(paper: "a4", margin: (top: 2.4cm, bottom: 2.2cm, left: 2.4cm, right: 2.4cm), numbering: "1")
  set text(font: fm, size: 11pt, lang: "zh")
  set par(justify: true, leading: 0.7em, first-line-indent: 0pt)
  set heading(numbering: "1.1")

  // 一级标题：居中 + 双线，不可分页
  show heading.where(level: 1): it => block(width: 100%, breakable: false, above: 1.8em, below: 1em)[
    #set align(center)
    #text(20pt, weight: "bold", fill: c1)[#line(length: 40%, stroke: 1.2pt + c2)]
    #v(0.5em)
    #text(20pt, weight: "bold", fill: c1)[#it.body]
    #v(0.5em)
    #line(length: 40%, stroke: 1.2pt + c2)
  ]

  // 二级标题：左侧色条
  show heading.where(level: 2): it => {
    set block(above: 1.2em, below: 0.5em)
    text(14pt, weight: "bold", fill: c3)[#box(width: 4pt, height: 1em, fill: c2)#h(6pt)#it.body]
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
    block(fill: cbg, stroke: 0.6pt + cbd, inset: 10pt, radius: 5pt, width: 100%, breakable: true)[
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
        align(center)[—— 欢迎交流 · 转载注明出处 ——]
      }
    },
  )

  // 封面：居中
  block(width: 100%, above: 4em, below: 2em)[
    #set align(center)
    #text(26pt, weight: "bold", fill: c1)[#title]
    #v(0.6em)
    #line(length: 18%, stroke: 1.2pt + c2)
    #v(0.6em)
    #if author != none { text(13pt, fill: rgb("#555555"))[#author] }
    #if date != none { text(11pt, fill: rgb("#888888"))[#if author != none { [ · ] }#date] }
  ]

  // 全局列表样式（set rules 在 doc 级别设置默认值）
  set list(
    marker: box(baseline: -0.13em)[
      #text(fill: c2, size: 0.55em)[●]
    ],
    indent: 0.8em,
    body-indent: 0.6em,
  )
  set enum(
    numbering: n => text(weight: "bold", fill: c2, size: 1em)[#n.],
    indent: 0.8em,
    body-indent: 0.6em,
  )

  // 无序列表：外框 + 间距
  show list: set par(first-line-indent: 0pt, leading: 0.7em)
  show list: it => {
    block(
      fill: rgb("#FAFBFC"),
      stroke: 0.5pt + rgb("#D5DCE6"),
      inset: (x: 14pt, y: 10pt),
      radius: 5pt,
      width: 100%,
      above: 0.5em,
      below: 0.6em,
    )[#it]
  }

  // 有序列表：外框 + 间距
  show enum: set par(first-line-indent: 0pt, leading: 0.7em)
  show enum: it => {
    block(
      fill: rgb("#FAFBFC"),
      stroke: 0.5pt + rgb("#D5DCE6"),
      inset: (x: 14pt, y: 10pt),
      radius: 5pt,
      width: 100%,
      above: 0.5em,
      below: 0.6em,
    )[#it]
  }

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

// 双列列表
#let col-list(left: (), right: (), gutter: 1.5em) = {
  block(inset: (left: 2em, top: 0.3em, bottom: 0.3em))[
    #set par(first-line-indent: 0pt)
    #grid(
      columns: (1fr, 1fr),
      gutter: gutter,
      [#for item in left {
        [
          - #item
        ]
      }],
      [#for item in right {
        [
          - #item
        ]
      }],
    )
  ]
}

// 命令速查表
#let cmds-table(..rows) = {
  align(center, block(fill: cta, stroke: 0.5pt + rgb("#D5DCE6"), inset: 12pt, radius: 4pt)[
    #set par(first-line-indent: 0pt)
    #text(12pt, weight: "bold", fill: c1)[🛠 常用命令速查]
    #v(6pt)
    #table(
      columns: (auto, auto, auto),
      stroke: none,
      inset: 6pt,
      align: (left, left, left),
      table.header([*操作*], [*命令*], [*说明*]),
      table.hline(),
      ..for row in rows.pos() { row },
    )
  ])
}

// 步骤列表
#let steps(..items) = {
  for (i, item) in items.pos().enumerate() {
    [#{ i + 1 }. #item]
    if i < items.pos().len() - 1 { v(0.3em) }
  }
}

// ── 通用数据表格 ──
// 用法：
//   #data-table(
//     columns: (auto, 1fr),
//     header: ([名称], [说明]),
//     [数字], [十进制数字],
//     [+], [加法符号],
//   )
// 或使用 table-header 参数指定表头内容
#let data-table(columns: auto, header: none, caption: none, ..rows) = {
  // 构建表格的所有 positional arguments
  let args = ()
  if header != none {
    for col in header {
      args.push(text(weight: "bold", fill: white)[#col])
    }
  }
  for r in rows.pos() {
    args.push(r)
  }

  block(above: 0.6em, below: 0.8em)[
    #if caption != none {
      text(10.5pt, weight: "bold", fill: c3)[#caption]
      v(0.35em)
    }
    #table(
      columns: columns,
      stroke: (x, y) => {
        if y == 0 { (bottom: 1pt + c2, top: 1pt + c2) } else if y == 1 and header != none {
          (bottom: 0.5pt + cbd)
        } else { none }
      },
      inset: (x: 10pt, y: 6pt),
      align: (center, left),
      fill: (x, y) => {
        if y == 0 { c2 } else if calc.rem(y, 2) == 0 { rgb("#F4F6FA") } else { none }
      },
      ..args,
    )
  ]
}
