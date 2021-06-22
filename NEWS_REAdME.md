# Як додавати нові новини на сторінку Краян

## Вступ. Структура сайту новин.

Всі новини на цьому майданчику формуються на основі окремих файлів: один
файл - одна новина. Фвйли новин на локальному сервері зберігаються в
каталозі `source/news`.  Файли, додані в цьому каталозі, на веб-сторінці
відображаються під посиланням `http://kraiany.org/news`. Кожна новина
може публікуватися від однієї до трьох мов: українською, англійською та
японською. Для кожної новини кожною мовою треба створити окремий файл з
текстом новини.

З кожного файлу з текстом новин формується сторінка і меню з заголовками
новин.  Щоб додати нову новину на сайт, потрібно створити файл
відповідною мовою і опублікувати новини. Після створення файла -- новина
з'явиться в меню новин.

*Зауваження*: Будьте уважні з форматуванням файлів. Якщо файл не
сформатований правильно, новина або не з'явиться в меню новин, або буде
видавати помилку при перегляді новин.

# Створення файлів для сайту новин

## Назва файлу

Всі файли новин повинні знаходитися в каталозі `source/news` і мати
назву відповідно до формату:

`<РІК>-<МІСЯЦЬ>-<ДЕНЬ>-<КОД МОВИ>-<НАЗВА>.html.<ДОДАТКОВИЙ ФОРМАТ>`

### Дата події чи публікації

`РІК`, `МІСЯЦЬ` і `ДЕНЬ` вище мають відповідати даті події (або публікації).

Рік - 4 цифри, місяць і день - 2 цифри. Наприклад: 2021-05-16 (16 травня
2021р).

### Код мови

Код мови повинен бути наступний:

- українська мова -- `uk`
- японська мова -- `ja` (Увага! не `jp`)
- англійська -- `en`

Файли з неправильним кодом мови не показуються.

### Назва новини

Назва може бути довільним текстом латиницею, всі слова між собою
розділені однією рискою ('-'). В цьому випадку формат не має особливого
значення.

### ДОДАТКОВИЙ ФОРМАТ

Використовується формат `markdown`. Див. розділ нижче

Отже повна назва файлу може бути для прикладу:

`2021-05-16-ja-parade-2021.html.markdown` (японська новина) або
`2021-05-16-uk-parade-2021.html.markdown` (та ж сама новина українською мовою).

---

## Формат файлу

Кожен складається з двох частин: метаданих і власне тіла новини.

### Метадані

Розділ метаданих іде вгорі файлу і відділяється трьома рисочками вгорі
(перший рядок файлу) та внизу.

#### Наприклад

```
---
title: 「第７回東京ウクライナ・パレード」のお知らせ
date: 2021-05-16 04:37 UTC
lastmod: 2021-05-16
changefreq: yearly
priority: 0.5
tags: パレード,ウクライナ,ヴィシヴァンカ,ビシバンカ
categories: release,parade
image: "/assets/images/parade-ja-2019.jpg"
---

```

Кожен рядок метаданих складається з етикетки і значення, які
розділяються двокрапкою. На даний момент на сторінці Краян
використувуються тільки `title:` і`date:`. Можливо інші типи метаданих
будуть використовуватися у майбутньому (наприклад: теги чи
категорії). Також насьогодні немає підтримки для фотографій, але в
майбутньому, підтримка зображень скоріше всього  буде додана.

Заголовок статті, який відображається в меню новин і на сторінці новини,
походить з рядка `title:`.

Формат дати у рядку `date:` важливий. Дата повинна відповідати тій даті,
яка записана в назві файлу.

### Текст новини

Формат тексту новини -- це звичайний текст розділений на абзаци
порожніми рядками. Це спрощений формат, який називається Markdown, детальний опис
формату можна знайти в мережі. Наприклад:
[вікіпедія](https://uk.wikipedia.org/wiki/Markdown) чи [офіційна
сторінка документації](https://www.markdownguide.org/basic-syntax/).

До речі: ця сторінка теж написана в Markdown, для швидкого ознайомлення
можна просто подивитися з чого вона складається.

#### Резюме статті

В новинах можна вживати спеціальний 'роздільник' -- ключове слово
`READMORE` -- окремо стояче на своєму рядку.

Як наприклад у:

```
---

日本の皆様にウクライナの文化に少しでも触れていただくため、第７回東京ウクライナ・パレードの開催を決定いたしました。

READMORE

日本在住のウクライナ人を中心とし、その友人や知人を招き、例年通り駐日ウクライナ大使イーホル・ハルチェンコ氏にも参加いただきまして、例年を越える盛大なパレードをお見せできることと思います。

```

В цьому випадку після заголовку статті у меню новин буде показано також
уривок тексту статті, який закінчується на 'роздільнику'. Якщо такого
роздільника не буде, то система сама вирішує, де обрізати коротке
резюме.