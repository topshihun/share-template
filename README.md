# Share Templates

存放日常分享的 Typst 模板集合。

---

## 模板列表

| 文件 | 用途 | 主色调 |
|------|------|--------|
| `tech-share-template.typ` | 技术分享 | 深蓝 `#1A3C6E` |
| `life-share-template.typ` | 生活分享 | 暖棕 `#8B5E3C` |
| `algo-share-template.typ` | 算法 / 题解 | 蓝黑 `#1B3A5C` |

---

## 快速开始

每个模板均导出 `doc` 主函数，用法一致：

```typ
#import "xxx-template.typ": *
#show: doc.with(title: "标题", author: "作者", date: datetime.today())
```

然后正常书写内容即可，所有标题样式和语义组件会自动应用。

---

## 一、tech-share-template.typ（技术分享）

深蓝色系，风格专业严谨，适合技术博客、工具介绍、开发心得等。

### 主函数 `doc`

```typ
#let doc(title: "技术分享", author: none, date: none, body)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `title` | string | `"技术分享"` | 文章标题，显示在封面和页眉 |
| `author` | string / none | `none` | 作者名，显示在封面 |
| `date` | datetime / none | `none` | 日期，显示在封面 |
| `body` | content | — | 正文内容 |

### 组件

#### `tip` — 小贴士 / 建议

蓝色调 callout，用于分享技巧、最佳实践、额外提示。

```typ
#tip("性能建议", "使用缓存可以大幅减少重复计算……")
```

#### `warn` — 警告

黄色调 callout，用于提醒常见陷阱、注意事项、破坏性变更。

```typ
#warn("注意", "此方法在 Python 3.12+ 中已废弃……")
```

#### `info` — 补充信息

绿色调 callout，用于补充背景知识、相关链接、延伸阅读。

```typ
#info("延伸阅读", "详见 RFC 2616 规范……")
```

#### `col-list` — 双列列表

将列表内容并排展示，适合对比、罗列利弊。

```typ
#col-list(
  left: ("优点1", "优点2", "优点3"),
  right: ("缺点1", "缺点2", "缺点3"),
  gutter: 1.5em,
)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `left` | array | `()` | 左列条目 |
| `right` | array | `()` | 右列条目 |
| `gutter` | length | `1.5em` | 列间距 |

#### `cmds-table` — 命令速查表

自动生成「操作 / 命令 / 说明」三列表格，适合 CLI 工具教程、速查手册。

```typ
#cmds-table(
  ("克隆仓库", `git clone <url>`, "拉取远程仓库到本地"),
  ("提交更改", `git commit -m "msg"`, "提交暂存区的修改"),
  ("推送远程", `git push`, "将本地提交推送到远端"),
)
```

#### `steps` — 步骤列表

带编号的操作步骤，适合教程、操作指南。

```typ
#steps(
  [安装依赖 `npm install`],
  [配置环境变量 `.env`],
  [启动服务 `npm run dev`],
)
```

#### `data-table` — 通用数据表格

带标题、表头蓝底白字、斑马纹的数据表格组件，适合展示结构化信息。

```typ
#data-table(
  caption: "词法分析 —— 非终结符一览",
  columns: (auto, 1fr),
  header: ([非终结符], [含义]),
  [Number], [十进制数字],
  [+], [加法符号],
  [-], [减法符号],
  [\*], [乘法符号],
  [/], [除法符号],
)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `columns` | array | `auto` | 列宽配置，如 `(auto, 1fr)` |
| `header` | array / none | `none` | 表头各列内容，如 `([名称], [说明])` |
| `caption` | string / none | `none` | 表格标题，显示在表格上方 |
| `..rows` | content | — | 表格数据行，按列依次传入 |

---

## 二、life-share-template.typ（生活分享）

暖棕色系，风格温馨柔和，适合游记、美食、日常感悟、读书笔记等。

### 主函数 `doc`

```typ
#let doc(title: "生活分享", author: none, date: none, body)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `title` | string | `"生活分享"` | 文章标题 |
| `author` | string / none | `none` | 作者名 |
| `date` | datetime / none | `none` | 日期 |
| `body` | content | — | 正文内容 |

### 组件

#### `tip` — 温馨小贴士

暖金色调 callout，用于分享生活小窍门、推荐、备忘。

```typ
#tip("旅行贴士", "建议提前预订民宿，节假日价格会上涨不少……")
```

#### `mood` — 心情标记

带 emoji 的心情卡片，适合记录当下感受或章节开篇的情绪铺垫。

```typ
#mood(icon: "😌", label: "此刻心情", "周末午后，阳光正好，泡一杯茶……")
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `icon` | string | `"😊"` | 表情符号 |
| `label` | string | `"心情"` | 标签文字 |
| `body` | content | — | 心情描述 |

#### `quote-box` — 引用 / 摘录

斜体引用块，支持标注来源，适合引用名言、书籍摘录、他人语录。

```typ
#quote-box("生活不止眼前的苟且，还有诗和远方的田野。", source: "高晓松")
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `body` | content | — | 引用内容 |
| `source` | string / none | `none` | 来源标注 |

#### `divider` — 分隔线

视觉分隔，可带文字标签，适合章节切换、氛围转折。

```typ
#divider()
#divider("未完待续")
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `content` | string / none | `none` | 分隔线上的文字，不传则为纯线条 |

#### `img-frame` — 图片框架

给图片加上边框和可选说明文字，适合展示照片。

```typ
#img-frame("photos/sunset.jpg", caption: "黄昏时分的长江大桥")
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `image-path` | string | — | 图片文件路径 |
| `caption` | string / none | `none` | 图片说明文字 |

#### `checklist` — 清单

带 ☐ 标记的待办/清单列表，适合旅行清单、购物清单、年度计划等。

```typ
#checklist(
  [护照和签证],
  [防晒霜和墨镜],
  [充电宝和转换插头],
)
```

---

## 三、algo-share-template.typ（算法 / 题解分享）

蓝黑色系，风格理性清爽。封面支持标签展示，适合 LeetCode 题解、算法讲解、竞赛复盘。

### 主函数 `doc`

```typ
#let doc(title: "算法分享", author: none, date: none, tags: (), body)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `title` | string | `"算法分享"` | 文章标题 |
| `author` | string / none | `none` | 作者名 |
| `date` | datetime / none | `none` | 日期 |
| `tags` | array | `()` | 标签列表，显示在封面 |
| `body` | content | — | 正文内容 |

### 组件

#### `tip` — 思路点拨

蓝色调 callout，用于分享解题思路、关键洞察、优化心得。

```typ
#tip("思路", "遇到有序数组查找问题，优先考虑二分答案……")
```

#### `warn` — 易错提醒

黄色调 callout，用于强调边界条件、常见错误、特判情况。

```typ
#warn("注意", "输入可能为空数组，需要单独处理……")
```

#### `info` — 背景知识

绿色调 callout，用于补充算法背景、数学推导、相关定理。

```typ
#info("前置知识", "需要了解前缀和与差分数组的基本概念……")
```

#### `complexity-tab` — 复杂度分析

专门展示时间/空间复杂度的组件，适合题解末尾的复杂度总结。

```typ
#complexity-tab(
  time: "O(n log n)",
  space: "O(n)",
  extra: "其中 n 为数组长度",
)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `time` | string | `"—"` | 时间复杂度 |
| `space` | string | `"—"` | 空间复杂度 |
| `extra` | string / none | `none` | 额外说明（如变量含义） |

#### `code-block` — 带语言标签的代码块

相比 Typst 原生 `` ``` `` 代码块，多了一个语言标签栏，适合展示具体语言的参考代码。

```typ
#code-block(lang: "Python")[
def two_sum(nums, target):
    seen = {}
    for i, v in enumerate(nums):
        if target - v in seen:
            return [seen[target - v], i]
        seen[v] = i
]
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `lang` | string | `"plain"` | 标签栏显示的语言名称 |
| `body` | content | — | 代码内容 |

#### `steps` — 解题步骤

圆形编号的步骤列表，适合描述算法整体流程。

```typ
#steps(
  [读入数据并预处理],
  [构建哈希表 / 前缀和],
  [遍历并计算答案],
  [输出结果],
)
```

#### `algo-steps` — 算法流程

紧凑的数字编号步骤，适合伪代码级别的算法描述。

```typ
#algo-steps(
  [初始化 `left = 0`, `right = n - 1`],
  [`while left <= right`：计算 `mid`],
  [比较 `nums[mid]` 与 `target` 并缩小区间],
  [返回结果索引或 -1],
)
```

#### `testcase` — 测试用例展示

结构化的示例输入/输出展示，适合配合题目描述使用。

```typ
#testcase(
  input: "nums = [2, 7, 11, 15], target = 9",
  output: "[0, 1]",
  explanation: "因为 nums[0] + nums[1] = 2 + 7 = 9",
)
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `input` | string | — | 输入描述 |
| `output` | string | — | 输出描述 |
| `explanation` | string / none | `none` | 解释说明 |

#### `ref-card` — 相关题目卡片

列出同类/延伸题目，适合题解末尾的拓展阅读。

```typ
#ref-card(
  [LeetCode 1 · Two Sum],
  [LeetCode 167 · Two Sum II],
  [LeetCode 15 · 3Sum],
)
```

---

## 通用约定

- 所有模板均使用 A4 纸张，正文 11pt 左右，中文优先。
- 自动处理页眉/页脚，封面页不显示页眉页脚。
- 一级至三级标题自动编号（`1.1` 格式）并应用模板专属样式。
- 各模板的 `tip` / `warn` / `info` 实际都基于同一个 `callout` 底座，仅在颜色和图标的预设上不同。
- **无序列表** 自动使用蓝色实心方块 `■` 标记，统一缩进和行距。
- **有序列表** 自动使用蓝色加粗编号（`1.` `2.` ...），统一缩进和行距。
- 列表自动禁用首行缩进，段落内行距统一为 `0.65em`。

---

## License

MIT © [topshihun](mailto:topshihun@qq.com)
