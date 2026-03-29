# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Kraiany.org — website for the Ukrainian community organization in Japan. Built with **Middleman 4.5** (Ruby static site generator), hosted on GitHub Pages.

- **Ruby**: 3.4.8
- **Template engine**: Slim (primary), also ERB and Markdown
- **CSS**: Bootstrap + custom SCSS via Sprockets
- **JS**: jQuery + Bootstrap JS via Sprockets
- **Languages**: Ukrainian (uk, default), English (en). Japanese (ja) exists in data/languages.yml but is not in the active `supported_languages` array.

## Development Commands

All commands run inside Docker.

```bash
# Build image (first time only)
docker build -t kraiany .

# Start dev server at http://localhost:4567
docker run --rm -v $(pwd):/app -p 4567:4567 kraiany

# Build site (outputs to ./build/)
docker run --rm -v $(pwd):/app kraiany build --verbose

# Check i18n health
docker run --rm -v $(pwd):/app kraiany i18n-tasks health

# Check for missing translations in build output
grep -lr 'translation missing' ./build
```

There is no test suite. CI validates via: i18n health check, successful build, and absence of "translation missing" in output.

## Architecture

### Localization (i18n)

Two localization approaches coexist:

1. **File-based**: Entire pages duplicated per language. Files named `<page>.<locale>.html.<format>` in `source/localizable/`. Example: `about.uk.html.md`, `about.en.html.md`.

2. **Fragment-based**: Shared template using `t("key.path")` calls. Translations live in `locales/` as YAML files, organized by section (subdirectories like `about/`, `donate/`, `parade/`) and top-level files (`en.yml`, `uk.yml`).

Config in `config.rb`: `activate :i18n, langs: [:uk, :en], :mount_at_root => false` — all pages are URL-prefixed (`/uk/`, `/en/`).

### Blog/News System

Articles in `source/news/` follow naming convention: `YYYY-MM-DD-{lang}-{slug}.html.{md|slim}`

Permalink pattern: `{lang}/news/{year}-{month}-{day}-{title}.html`

Frontmatter fields: `title`, `details`, `date`, `image`, `tags`, `categories`.

Use `READMORE` marker in article body to define summary cutoff.

### Layouts

- `source/layouts/default.slim` — base layout (header, navbar, footer)
- `source/layouts/news.slim` — blog article layout
- `source/layouts/page.slim` — generic page layout
- Key partials: `_header`, `_navbar`, `_footer`, `_language_select` (all `.html.slim`)

### Assets

Sprockets pipeline — use `//= require` directives in:
- `source/assets/stylesheets/site.css.scss` (entry point)
- `source/assets/javascripts/site.js` (entry point)

Build applies: minification (CSS/JS/HTML), asset hashing (cache busting), gzip.

### Helpers (config.rb)

- `current_language` — returns language data hash for active locale
- `current_with_locale(locale)` — generates URL for current page in another language
- `alternate_lang_pages(page)` — returns all language versions of a page
- `translated_title` — resolves page title from frontmatter or i18n key

### Redirects

Extensive redirect rules at the bottom of `config.rb` handle legacy URLs, QR code landing pages, and external service links. Add new redirects there.

## Deployment

Push/merge to `master` triggers GitHub Actions (`.github/workflows/build.yml`):
1. i18n health check
2. `middleman build --verbose`
3. Missing translation check
4. Deploy `./build/` to `gh-pages` branch via `peaceiris/actions-gh-pages`
