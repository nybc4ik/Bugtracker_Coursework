#import "@preview/modern-g7-32:0.2.0": gost, abstract, appendixes, appendix-heading, enum-numbering

#set par(justify: true)
#set par(leading: 1.0em)

#set math.equation(numbering: "(1)")

#set figure.caption(separator: [ -- ])

#show figure.where(
  kind: table
): set figure.caption(position: top, separator: ". ")

#show figure.where(
  kind: raw
): set figure.caption(position: top, separator: ". ")

#show raw: set text(font: "Courier New", size: 10pt)

#let codeblock(filename) = raw(
  read(filename, encoding: "utf8"),
  block: true,
  lang: filename.split(".").at(-1)
)

#set list(tight: true)
#set enum(indent: 1.25cm)


#let assets = "./"

#import (assets + "style.typ"): template-bmstu, title-bmstu

#show: template-bmstu

#set page(footer: context {
  if counter(page).get().first() > 1 [
    #align(center, context counter(page).display("1"))
  ]  
})

#set list(indent: 1.25cm, marker: [--])


#title-bmstu( 
  ("5",
  "Аппроксимация методом", "наименьших квадратов"),
  "Камаев С. М.",
  "Коновалов А. .",
  "ИУ9-61Б"
)

#set heading(numbering: "1.")

#pagebreak()

= Введение

= Проектирование базы данных
== Проектирование ER модели
В процессе проектирования базы данных мною была разработана ER-модель, показанная на рисунке 1.
 #align(center,
    image("ЕР-модель.jpg", width: 100%)
  ) 

Модель включает в себя следующие сущности, каждая из которых выполняет определённую роль в работе:
+ Пользователь
= Практическая часть 

== Индивидуальный вариант

Вариант 23: 

Таблично-заданная функция:

#table(
  columns:(1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr),
  [$x$],[*1*],[*1,5*],[*2*],[*2,5*],[*3*],[*3,5*],[*4*],[*4,5*],[*5*],
  [$f(x)$],[2,57],[2,96],[3,08],[2,56],[3,45],[3,16],[2,99],[4,00],[4,21]
)

$z(x)$ -- аппроксимация:


== Программная реализация

В листинге представлена реализация программы, осуществляющей выбор нелинейной аппроксимации для выбранных значений $y_a, y_g, y_h$, $z_a, z_g, z_h$ и вычисление коэффициентов $a, b$ методом наименьших квадратов, на языке C++.

// #codeblock("../code/main.cpp")


== Результаты тестирования

#pagebreak()

= Выводы

В данной лабораторной работе я реализовал программу для аппроксимации таблично-заданной функции методом наименьших квадратов. Выбор аппроксимации основывается на поведении функции в трёх различных средних точках (среднее арифметическое, геометрическое и гармоническое), поэтому перед применением собственно метода наименьших квадратов необходимо произвести ручную аппроксимацию функции $z(x)$. Для моего индивидуального варианта лучше всего подходит линейная аппроксимация $z_1(x) = alpha x+ beta$, однако с целью ввода шага линеаризации для всех вариантов $z_1$ была исключена из возможных решений, и следующая лучшая аппроксимация $z_6(x) = 1/(alpha x + beta)$ даёт приемлемый результат (среднеквадратичная ошибка < 1).

