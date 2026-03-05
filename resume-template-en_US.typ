#import "template.typ": *

// Theme color
#let theme-color = rgb("#000000")
#let icon = icon.with(fill: theme-color)

// Icons: https://fontawesome.com/icons/
#let fa-award = icon("icons/fa-award.svg")
#let fa-building-columns = icon("icons/fa-building-columns.svg")
#let fa-code = icon("icons/fa-code.svg")
#let fa-envelope = icon("icons/fa-envelope.svg")
#let fa-github = icon("icons/fa-github.svg")
#let fa-graduation-cap = icon("icons/fa-graduation-cap.svg")
#let fa-linux = icon("icons/fa-linux.svg")
#let fa-phone = icon("icons/fa-phone.svg")
#let fa-windows = icon("icons/fa-windows.svg")
#let fa-wrench = icon("icons/fa-wrench.svg")
#let fa-work = icon("icons/fa-work.svg")
#let fa-trophy = icon("icons/fa-trophy.svg")
#let fa-weixin = icon("icons/fa-weixin.svg")
#let fa-book = icon("icons/fa-book.svg")
#let fa-cogs = icon("icons/fa-gear.svg")
#let fa-briefcase = icon("icons/fa-briefcase.svg")

#let section_heading(icon, title) = box(inset: 0.5pt)[#icon #h(0.1em)#title]
#let inline_logo(path, h: 1.55em) = box(
  baseline: 100%,
  inset: 0pt,
  image(path, height: h),
)

// Spacing knobs
#let line_leading = 0.6em
#let paragraph_spacing = 0.6em
#let bullet_item_spacing = 0.6em
#let bullet_indent = 0.5em
#let page_margin_left = 0.86cm
#let page_margin_right = 0.86cm
#let edu_col_icon = 1.55em
#let edu_col_school = 7.7cm
#let edu_col_major = 1fr
#let edu_col_right = 5.5cm
#let edu_col_gutter = 0.22em
#let edu_row_spacing = 0.04em

#let edu_row(
  icon_path,
  school,
  major,
  degree,
  date,
) = grid(
  columns: (edu_col_icon, edu_col_school, edu_col_major, edu_col_right),
  column-gutter: edu_col_gutter,
  align: (left + bottom, left + bottom, left + bottom, right + bottom),
  [#inline_logo(icon_path)],
  [*#school*],
  [#emph[#major]],
  [#emph[#degree] #h(0.8em) #date],
)

#let bullet_line(body) = pad(
  left: bullet_indent,
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.28em,
    align: (left, left),
    [•],
    [#body],
  ),
)

#set page(footer: none)

#show: resume.with(
  size: 9pt,
  theme-color: theme-color,
  margin: (
    top: 1cm,
    bottom: 0cm,
    left: page_margin_left,
    right: page_margin_right,
  ),
  photograph: "",
  photograph-width: 0em,
  gutter-width: 0em,
)[
  #set text(font: ("Times New Roman"), size: 10.8pt, lang: "en")
  #set par(leading: line_leading, spacing: paragraph_spacing)

  #grid(
    columns: (1fr, auto),
    column-gutter: 1cm,
    [
      = Resume Template (EN)
      #h(1.2em)
      #stack(
        spacing: 1.1em,
        [#fa-phone Phone: (+1) 617-555-0142],
        [#fa-envelope Email: resume.template\@example.com],
        [#fa-github Website: #link("https://github.com/resume-template")[#underline[github.com/resume-template]]],
      )
    ],
    [
      #align(right)[#image("IDphoto.png", height: 2.8cm)]
    ],
  )
][
  #set text(font: ("Times New Roman"), size: 10.8pt, lang: "en")
  #set par(leading: line_leading, spacing: paragraph_spacing)

  == #section_heading(fa-graduation-cap, "Education")

  #edu_row("icon/pku.png", [Peking University], [Computer Science and Technology], [B.S.], [Sep 2017 - Jun 2021])
  #v(edu_row_spacing)
  #edu_row("icon/mit.svg.png", [Massachusetts Institute of Technology (MIT)], [Computer Science], [Ph.D.], [Sep 2021 - Jun 2026])

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*Research Interests*: large language models, reasoning enhancement, agent systems, and multimodal learning.],
    bullet_line[*Representative Courses*: machine learning, probabilistic graphical models, distributed systems, advanced algorithms, statistical inference, and optimization.],
    bullet_line[*Academic Service*: reviewer for multiple top-tier conferences and contributor to cross-institution research collaborations.],
  )

  == #section_heading(fa-book, "Publications")

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*Attention Is All You Need* (arXiv:1706.03762, 2017)],
    bullet_line[*Authors*: Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, Illia Polosukhin],
    bullet_line[*Core Contribution*: proposes the Transformer architecture based solely on attention mechanisms, fully removing recurrence and convolutions while improving parallel training efficiency.],
    bullet_line[*Key Results*: BLEU 28.4 on WMT14 En-De (+2+ over previous best) and BLEU 41.8 on WMT14 En-Fr (single-model SOTA).],
  )

  == #section_heading(fa-trophy, "Honors & Awards")

  #pad(left: bullet_indent)[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.35em,
      row-gutter: bullet_item_spacing,
      align: (left, left, right),
      [•],
      [Nobel Prize in Physics],
      [*2024*],
      [•],
      [Nobel Prize in Chemistry],
      [*2023*],
      [•],
      [Nobel Memorial Prize in Economic Sciences],
      [*2022*],
    )
  ]

  == #section_heading(fa-cogs, "Skills")

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*Programming Languages*: Python, C++, Rust, SQL.],
    bullet_line[*Models & Systems*: PyTorch, JAX, distributed training, RAG, agent workflows, and online inference optimization.],
    bullet_line[*Engineering*: able to turn research prototypes into production-ready systems with observability, evaluation, and staged rollout support.],
  )

  == #section_heading(fa-briefcase, "Internship Experience")

  #grid(
    columns: (auto, 5.4cm, 1fr, auto),
    column-gutter: 0.45em,
    align: (left + bottom, left + bottom, left + bottom, right + bottom),
    [#inline_logo("icon/Openai.ico.png")],
    [#link("https://openai.com/")[#underline[*OpenAI*]]],
    [Research Engineering Intern],
    [Jun 2025 - Sep 2025],
  )
  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*STAR framework*: STAR is a structured way to present experience. *S (Situation)* describes the context, *T (Task)* defines the goal, *A (Action)* explains what you did, and *R (Result)* presents measurable outcomes.],
    bullet_line[*Writing guideline*: describe context and objective first, then explain your key actions, and end with quantifiable impact (for example, quality, latency, cost, or efficiency improvements).],
  )

  #grid(
    columns: (auto, 5.4cm, 1fr, auto),
    column-gutter: 0.45em,
    align: (left + bottom, left + bottom, left + bottom, right + bottom),
    [#inline_logo("icon/gemini.png")],
    [#link("https://deepmind.google/technologies/gemini/")[#underline[*Google DeepMind (Gemini)*]]],
    [Core Research Intern (Gemini 3.1 Pro)],
    [Oct 2025 - Feb 2026],
  )
  #stack(
    spacing: bullet_item_spacing,
    bullet_line[
      *S (Situation)*: the team needed to improve Gemini 3.1 Pro under a fixed compute budget while keeping training stable. \
      *T (Task)*: own the design, execution, and iteration of the Gemini 3.1 Pro training pipeline. \
      *A (Action)*: optimized data mixture, scheduling, and hyperparameters; tracked convergence and key benchmarks by phase; and quickly rolled back and retrained unstable runs. \
      *R (Result)*: improved convergence stability and training efficiency, with SOTA-level performance on math reasoning, coding, and long-context tasks.
    ],
  )

  #line(length: 100%)
  #v(0.15em)
  #text(size: 8.1pt)[
    #fa-github #h(0.12em)*GitHub*: #link("https://github.com/resume-template")[#underline[resume-template]], #fa-weixin #h(0.12em)*WeChat*: ResumeTemplate
  ]
]
