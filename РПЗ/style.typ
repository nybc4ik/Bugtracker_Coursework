#let template-bmstu(doc) = [
  #set page(paper: "a4", margin: (y: 20mm, left: 30mm, right: 20mm))
  #set par(first-line-indent: (amount: 1.25cm, all: true))
  #set text(font: "Times New Roman", size: 13pt, lang: "ru")
  #doc
]

#let title-bmstu(
  subject,
  student,
  chief,
  group,
  city: "Москва",
  faculty: "Информатика и системы управления",
  specialty: "Теоретическая информатика и компьютерные технологии",
  emblem-path: "Emblem.png"
  
) = [
  #let sign = "(Подпись, дата)"
  #let name = "(И. О. Фамилия)"
  #let field_width = 8em;
  #let field_gutter = 1em;

  #set page(footer: context {
  if counter(page).get().first() == 1 [
    #align(center)[_#city, 2026 г._]
  ]
  })

  #set par(first-line-indent: 0em)

  #grid(
    columns: (1fr),
    rows: (auto, auto, 1fr, auto, 1fr,1fr),
    row-gutter: 1em,
  [
    #grid(
      columns: (4em, 1fr), // Defines two columns: one auto-sized for the image, one taking remaining space for text
      gutter: 0em,          // Adds a 1em space between the columns
      [
        #block(
          clip: true,
          height: 7em,
          image(emblem-path, alt: "МГТУ им. Н. Э. Баумана", width: 4em, height: 8em)
        )
      ],
      [
        #set align(center)

        #set text(weight: "bold", size: 13pt)
        #set par(leading: 0.5em)
    Министерство науки и высшего образования Российской Федерации
    Федеральное государственное автономное образовательное \ учреждение высшего образования \
    «Московский государственный технический университет \
    имени Н. Э. Баумана \
    (национальный исследовательский университет)» \
    (МГТУ им. Н. Э. Баумана)
      ]
    )
    // lines
    #box(width: 100%, height: 0.2em, stroke: (top: 2.5pt, bottom: 0.4pt))
  ],
  [
    #grid(
      columns: (auto, 1fr), // Defines two columns: one auto-sized for the image, one taking remaining space for text
      gutter: 0em,          // Adds a 1em space between the columns
      [
        ФАКУЛЬТЕТ
      ],
      [
        #box(width: 1fr, height: 1em, stroke: (bottom: 0.5pt)
        )[#align(center)[#faculty]]
      ]
    )
    #grid(
      columns: (auto, 1fr), // Defines two columns: one auto-sized for the image, one taking remaining space for text
      gutter: 0em,          // Adds a 1em space between the columns
      [
        КАФЕДРА
      ],
      [
        #box(width: 1fr, height: 1em, stroke: (bottom: 0.5pt))[#align(center)[#specialty]]
      ]
    )
  ],
  [],
  [
    #align(center)[
    #set text(weight: "bold", size: 20pt)
    #set par(leading: 0.8em)
    #upper[Курсовая работа] \
    #upper[_на тему:_] \
      #box(width: 90%, height: 1em, stroke: (bottom: 1pt)
        )[_#subject.at(1, default: "")_] \
      #box(width: 90%, height: 1em, stroke: (bottom: 1pt)
        )[_#subject.at(2, default: "")_] \
      #box(width: 90%, height: 1em, stroke: (bottom: 1pt)
        )[_#subject.at(3, default: "")_] \
      #box(width: 90%, height: 1em, stroke: (bottom: 1pt)
        )[_#subject.at(4, default: "")_] \
      #box(width: 90%, height: 1em, stroke: (bottom: 1pt)
        )[_#subject.at(5, default: "")_] \
  ]
  ],  
  [],
  [
    #grid(
      columns: (auto, auto, 1fr, auto, auto), // Defines two columns: one auto-sized for the image, one taking remaining space for text
      gutter: 1em,          // Adds a 1em space between the columns
      [
        Студент 
      ],
      [
        #box(width: 4em, height: 1em, stroke: (bottom: 0.5pt))[#align(center)[#group]]
        #v(-1em)
        #text(size: 0.75em)[#align(center)[(Группа)]]
      ],
      [
      ],
 
      [
        #box(width: field_width, height: 1em, stroke: (bottom: 0.5pt))[#align(center)[#student]]
        #v(-1em)
        #text(size: 0.75em)[#align(center)[#name]]
      ]
    )

    #grid(
      columns: (auto, 1fr, auto, auto), // Defines two columns: one auto-sized for the image, one taking remaining space for text
      gutter: 1em,          // Adds a 1em space between the columns
      [
        Руководитель курсовой работы 
      ],
      [

      ],
    
      [
        #box(width: field_width, height: 1em, stroke: (bottom: 0.5pt))[#align(center)[#chief]]
        #v(-1em)
        #text(size: 0.75em)[#align(center)[#name]]
      ],
      
    )

   
  ], []
  )]

  



