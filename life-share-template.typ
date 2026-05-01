// ============================================================
//  life-share-template.typ — 生活分享模板
//
//  License: MIT — Copyright (c) 2025 topshihun <topshihun@qq.com>
//
//  用法：
//    #import "life-share-template.typ": *
//    #show: doc.with(title: "标题", author: "作者", date: datetime.today())
//
//  组件：tip, mood, quote-box, divider, img-frame, checklist
// ============================================================

// ── 颜色（温暖柔和系） ──
#let c1 = rgb("#8B5E3C")  // 主色：暖棕
#let c2 = rgb("#E8A87C")  // 强调：杏色
#let c3 = rgb("#A67C52")  // h2
#let c4 = rgb("#C4956A")  // h3
#let cbg = rgb("#FFF8F0")  // 代码块/引用背景：浅杏
#let cbd = rgb("#E8D5C4")  // 边框
#let cib = rgb("#FFF0E0")  // 行内背景
#let cif = rgb("#D4745C")  // 行内前景：暖红
#let ctb = rgb("#FFFBF5")  // tip 背景
#let ctl = rgb("#F4A460")  // tip 左边框：沙棕色
#let ctt = rgb("#B8860B")  // tip 标题色：深金色
#let ctc = rgb("#5C4033")  // tip 正文色
#let ch = rgb("#C4A88C")  // 页眉
#let cf = rgb("#D4C4B0")  // 页脚

// ── 字体 ──
#let fm = ("Source Han Sans", "Times New Roman", "SimSun")
#let fc = ("JetBrainsMono NFM", "Consolas", "DejaVu Sans Mono")

// ═══════════════════════════════════════════════
//  主函数
// ═══════════════════════════════════════════════

#let doc(title: "生活分享", author: none, date: none, body) = {
  set page(paper: "a4", margin: (top: 2.4cm, bottom: 2.2cm, left: 2.6cm, right: 2.6cm), numbering: "1")
  set text(font: fm, size: 11.5pt, lang: "zh")
  set par(justify: true, leading: 0.75em, first-line-indent: 0pt)
  set heading(numbering: "1.1")

  // 一级标题：居中 + 波浪线
  show heading.where(level: 1): it => block(width: 100%, breakable: false, above: 2em, below: 1.2em)[
    #set align(center)
    #text(22pt, weight: "bold", fill: c1)[~ ~ ~ ~ ~ ~ ~ ~ ~ ~]
    #v(0.4em)
    #text(22pt, weight: "bold", fill: c1)[#it.body]
    #v(0.4em)
    #text(22pt, weight: "bold", fill: c1)[~ ~ ~ ~ ~ ~ ~ ~ ~ ~]
  ]

  // 二级标题：左侧圆点
  show heading.where(level: 2): it => {
    set block(above: 1.4em, below: 0.6em)
    text(15pt, weight: "bold", fill: c3)[#box(circle(width: 10pt, height: 10pt, fill: c2)) #h(8pt) #it.body]
  }

  // 三级标题
  show heading.where(level: 3): it => {
    set block(above: 1em, below: 0.3em)
    text(12.5pt, weight: "bold", fill: c4)[#it.body]
  }

  // 代码块
  show raw: set text(font: fc, size: 9pt)
  show raw.where(block: true): it => {
    set block(above: 0.5em, below: 0.6em)
    block(fill: cbg, stroke: 0.6pt + cbd, inset: 10pt, radius: 6pt, width: 100%, breakable: true)[
      #set par(first-line-indent: 0pt)
      #it
    ]
  }
  show raw.where(block: false): it => box(fill: cib, inset: (x: 3pt, y: 1pt), radius: 3pt)[
    #text(fill: cif)[#it]
  ]

  // 页眉页脚
  set page(
    header: context {
      if counter(page).get().first() != 1 {
        set text(9pt, fill: ch)
        line(length: 100%, stroke: 0.4pt + rgb("#E0D5C8"))
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
        align(center)[—— 记录生活 · 分享美好 ——]
      }
    },
  )

  // 封面：居中
  block(width: 100%, above: 5em, below: 2.5em)[
    #set align(center)
    #text(28pt, weight: "bold", fill: c1)[#title]
    #v(0.5em)
    #text(14pt, fill: c2)[— ✿ —]
    #v(0.5em)
    #if author != none { text(13pt, fill: rgb("#7A6B5F"))[#author] }
    #if date != none { text(11pt, fill: rgb("#A89888"))[#if author != none { [ · ] }#date] }
  ]

  body
}

// ═══════════════════════════════════════════════
//  语义组件
// ═══════════════════════════════════════════════

// tip：温馨小贴士
#let tip(title, body) = {
  block(
    above: 0.6em,
    below: 0.6em,
    fill: ctb,
    stroke: (left: 3.5pt + ctl),
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    width: 100%,
  )[
    #text(10.5pt, weight: "bold", fill: ctt)[🌿 #title]
    #v(4pt)
    #text(10.5pt, fill: ctc)[#set par(first-line-indent: 0pt); #body]
  ]
}

// mood：心情标记
#let mood(icon: "😊", label: "心情", body) = {
  block(
    above: 0.5em,
    below: 0.5em,
    fill: rgb("#FFF5EE"),
    stroke: 0.5pt + rgb("#F0DCC8"),
    inset: (x: 14pt, y: 8pt),
    radius: 8pt,
    width: 100%,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter: 10pt,
      [#text(2em)[#icon]],
      [
        #text(10.5pt, weight: "bold", fill: c3)[#label]
        #v(3pt)
        #text(10.5pt, fill: ctc)[#set par(first-line-indent: 0pt); #body]
      ],
    )
  ]
}

// quote-box：引用 / 摘录
#let quote-box(body, source: none) = {
  block(
    above: 0.6em,
    below: 0.6em,
    fill: rgb("#FAF5EF"),
    stroke: (left: 3pt + cbd),
    inset: (x: 14pt, y: 10pt),
    radius: 3pt,
    width: 100%,
  )[
    #set par(first-line-indent: 0pt)
    #text(11pt, style: "italic", fill: rgb("#6B5B4F"))[#body]
    #if source != none {
      v(6pt)
      align(right, text(9.5pt, fill: rgb("#A89888"))[—— #source])
    }
  ]
}

// divider：分隔线
#let divider(content: none) = {
  block(above: 1em, below: 1em)[
    #set align(center)
    #if content != none {
      text(9pt, fill: cbd)[—— #content ——]
    } else {
      line(length: 60%, stroke: 0.5pt + cbd)
    }
  ]
}

// img-frame：图片框架（预留）
#let img-frame(image-path, caption: none) = {
  block(above: 0.6em, below: 0.6em, inset: 6pt)[
    #set align(center)
    #block(
      stroke: 0.8pt + cbd,
      inset: 4pt,
      radius: 4pt,
    )[
      #image(image-path, width: 80%)
    ]
    #if caption != none {
      v(4pt)
      text(9pt, fill: rgb("#A89888"))[#caption]
    }
  ]
}

// checklist：清单（可选带勾选标记）
#let checklist(..items) = {
  block(inset: (left: 1em, top: 0.3em, bottom: 0.3em))[
    #set par(first-line-indent: 0pt)
    #for item in items.pos() {
      [#box(width: 1.2em)[☐] #item]
      v(0.25em)
    }
  ]
}
