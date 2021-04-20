# [www.kraiany.org](https://www.kraiany.org/) [![Build Status](https://travis-ci.org/Kraiany/kraiany.github.io.svg?branch=develop)](https://travis-ci.org/Kraiany/kraiany.github.io)
Home for the Kraiany projects



## Contributing

1. Fork the repo on GitHub
2. Clone the project to your own machine
3. Commit changes to your own branch
4. Push your work back up to your fork
5. Submit a Pull request so that we can review your changes

*Please note*: All Pull Requests should be submitted against `develop`
branch, not `master`. Please see explanation below.

## Локалізація

Локалізація — переклади і демонстрація сторінки кількома мовами (українська, японська, англійська). 

Локалізація в цьому проекті може здійснюватися одним із двох способів:
- переклад текстових фрагментів у HTML файлах і використання для цього функції `t()` (скорочене від translate)
- або переклад всіх файлів цілком. 
  В цьому випадку для визначення мови використовується розширення файлу `en`, `ja` чи `uk` (`file.ja.html`, `file.en.html`, `file.uk.html`). 
  Форматування файлів в цьому останньому випадку має бути ідентичним, тільки текстовий матеріал різний.

### Переклад текстових фрагментів

В цьому випадку використовується база даних перекладів у файлах типу YAML. YAML — це структурований формат. Опис формату можна знайти на [вікіпедії](https://uk.wikipedia.org/wiki/YAML).


Приклад локалізації (файл index.html.slim):

    p = t "kraiany.about"
    h2
      = link_to t("festival.festival"), "/festival", class: "btn btn-white"
      = link_to t("parade.parade"), "/#{locale}/parade.html", class: "btn btn-white"
      = link_to t("news.news"), "/#{locale}/news.html", class: "btn btn-white"

В цьому прикладі: 

- Перекладаються рядки, прописані в аргументах функції `t()`. Тобто:  `t("festival.festival")`, `t("parade.parade")`. Інколи дужки можна опускати, як, наприклад у випадку `t "kraiany.about"`. 
  Текстові аргументи (festival.festival, parade.parade) в цьому випадку не є текстом для перекладу, а ключами у YAML файлі перекладів. 
- Файли перекладів знаходяться в каталозі `source/locales` у файлах типу YAML, (наприклад: `parade.yml`, або `en.yml`, `jp.yml`, `uk.yml`). 
- Переклади шукаються у структурованому тексті [YAML](https://uk.wikipedia.org/wiki/YAML). Наприклад, для перекладу `festival.festival` з файлу source/locales/(en,uk,jp).yml (в залежності від активної на даний момент мови), вибереться значення такої структури: "(мова) -> festival -> festival"

Приклад англійського перекладу:


```
en:                     <--- мова
  [...]
  festival:             <--- перший аргумент
    festival: Festival  <--- другий аргумент і значення
```

Японський файл
```
ja:                          <--- мова
  email: メールアドレス
  subscribe: 登録する
  receive_information: 今後のイベントの情報を受け取る
  festival:                 <--- перший аргумент
    festival: フェスティバル   <--- другий аргумент і значення
```

### Переклад файлів цілком

ДАЛІ БУДЕ

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
