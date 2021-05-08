# [www.kraiany.org](https://www.kraiany.org/) [![Build Status](https://travis-ci.org/Kraiany/kraiany.github.io.svg?branch=develop)](https://travis-ci.org/Kraiany/kraiany.github.io)
Home for the Kraiany projects

Це репозиторій домашньої сторінки НПО Краяни, Громади українців в
Японії. Сторінка в інтернеті опублікована за адресою [www.kraiany.org](https://www.kraiany.org/)

## Contributing

Якщо ви хочете додати щось до сторінки Краян:

1. Fork the repo on GitHub
2. Clone the project to your own machine
3. Commit changes to your own branch
4. Push your work back up to your fork
5. Submit a Pull request so that we can review your changes

*Please note*: All Pull Requests should be submitted against `develop`
branch, not `master`. Please see explanation below.

---

## Локалізація

Локалізація сторінки -- це переклади і відображення сторінки кількома
мовами (українська, японська, англійська в нашому випадку).

Локалізація в цьому проекті може здійснюватися одним із двох способів:

### Локалізація файлів

- Для файлів, переважно текстових, у яких відносно небагато HTML
  форматування, файли перекладаються цілком. При цьому, мовні версії
  файлів записуються з різними назвами файлів, у яких відрізняється
  тільки позначка мови. Назви файлів повинні відрізнятися розширенням
  мови файлу (`en`, `ja` чи `uk` відповідно для англійської, японської
  чи української) Для визначення мови використовується розширення файлу
  `en`, `ja` чи `uk` (`2020-01-22-ja-file.html`,
  `2020-01-22-en-file.html`, `2020-01-22-uk-file.html`).  Форматування
  файлів в цьому випадку має бути ідентичним, тільки текстовий матеріал
  різний.

  Структура назви файлу повинна бути відповідною до: `<ДАТА-У-ФОРМАТІ-РІК-МІСЯЦЬ-ДЕНЬ>-<МОВА>-<НАЗВА>.html.markdown`

  За приклад, можна взяти вже існуючі файли перекладів:

  - `2019-11-25-en-costume-2019.html.markdown`
  - `2019-11-25-ja-costume-2019.html.markdown`
  - `2019-11-25-uk-costume-2019.html.markdown`

### Локалізація текстових фрагментів

- Для сторінок, багатих на HTML форматування і з відносно невеликим
  об'ємом тексту, використовується переклад тектсових фрагментів. Для
  позначення текстових фрагментів для перекладу використовуються
  позначки-етикетки з використанням функції `t()`(скорочене від
  `translate`), а для перекладу кожною мовою використувуються текстові
  фрагменти з структурованих файлів YAML.


#### Переклад текстових фрагментів

В цьому випадку використовується база даних перекладів у файлах типу YAML. YAML — це структурований формат. Опис формату можна знайти на [вікіпедії](https://uk.wikipedia.org/wiki/YAML).


Приклад локалізації (файл `index.html.slim`):

    p = t "kraiany.about"
    h2
      = link_to t("festival.festival"), "/festival", class: "btn btn-white"
      = link_to t("parade.parade"), "/#{locale}/parade.html", class: "btn btn-white"
      = link_to t("news.news"), "/#{locale}/news.html", class: "btn btn-white"

В цьому прикладі:

- Все, що є аргументом функції `t()` перекладається, використовуючи як
  базу файли YAML. У наступних прикладах  `t("festival.festival")`,
  `t("parade.parade")` замість `festival.festival` та `parade.parade`
  буде відповідно вставлено переклад однією з трьох мов.

  *Примітка*: Інколи дужки функції `t()` можна опускати, як, наприклад у
  випадку `t "kraiany.about"` є тим же самим, що і `t("kraiany.about")`.

- Файли перекладів знаходяться в каталозі `source/locales` у файлах типу
    YAML, (наприклад: `parade.yml`, або `en.yml`, `jp.yml`, `uk.yml`).

- Переклади знаходяться у структурованому тексті
  [YAML](https://uk.wikipedia.org/wiki/YAML). Наприклад, для перекладу
  `festival.festival` з файлу source/locales/(en,uk,jp).yml (в
  залежності від активної на даний момент мови), вибереться значення
  такої структури: "(мова) -> festival -> festival"

Приклад англійського перекладу:


```
en:                     <--- мова
  [...]
  festival:             <--- перший аргумент
    festival: Festival  <--- другий аргумент і значення
```

Японський файл перекладів
```
ja:                          <--- позначка мови
  email: メールアドレス <---- перший відступ (2 пробіли)
  subscribe: 登録する
  receive_information: 今後のイベントの情報を受け取る
  festival:
    festival: フェスティバル   <--- другий відступ (4 пробіли), аргумент і значення
```

## Файли локалізації

Переклади текстових фрагментів файлів знаходяться у кількох
різноманітних файлах. В залежності від того, яку сторінку ви збираєтеся
локалізувати або ж додати свою власну сторінку з перекладами трьома
мовами, вам потрібно знати розташування цих файлів (з часом ця структура
може змінюватися).

### Файли

- `locales/kraiany.yml` -- загальна інформація про Краяни: назва,
  коротка інформація, тощо.
- `locales/parade.yml` -- текстові фрагменти, використані в об'явах про
  паради вишиванок
- `locales/news.yml` -- розділ новин сторінки


---

## Github pages and Branches

This project uses [GihubPages](https://pages.github.com/) for hosting
final, parsed site. The way Github pages work sets how branches are used
in this project.

- `master` branch -- generated HTML, CSS, JS code.

- `develop` branch -- main branch to submit PR's, testing and source of
the deployment.

Merge of the PR to `develop` branch triggers automated testing and
deploy of the master branch.

Workflow of the deployment is as follows:


```
                              Travis      Final
              PR              deploy      site
[USER BRANCH] --> [`develop`] -------> [`master`]


```

## Docker

Simpler setup using Docker.


### Build image

```
docker build -t kraiany .

```

### Develop

```

 docker run -it  --rm -v $(pwd):/app -p 4567:4567 kraiany
 open http://localhost:4567


```


### Deploy

```

docker run -it  --rm -v $(pwd):/app -v ~/.gitconfig:/root/.gitconfig  -p 4567:4567 kraiany deploy

```
