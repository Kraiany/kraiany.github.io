###
# Page options, layouts, aliases and proxies
###

set :encoding, 'utf-8'
set :index_file, 'index.html'
# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

activate :i18n, langs: [:ja, :en, :uk]
activate :directory_indexes

# --------------------------------------------
# Localization helpers
# --------------------------------------------
helpers do

  def current_language
    data.languages[I18n.locale]
  end

  def available_locales_as_regex
    I18n.config.available_locales.map(&:to_s).join("|")
  end

  # URL of the current page with stripped locale prefix.
  def current_without_locale
    current_page.url
    .sub(%r{^/(#{ available_locales_as_regex})/},'/')
  end

  # Prefix page with locale
  #
  def current_with_locale(locale)
    if locale == I18n.default_locale.to_s
      current_without_locale
    else
      "/#{locale}/#{current_without_locale}"
    end
      .gsub(%r{/+}, "/")
  end

  def locale_prefix(locale=I18n.locale)
    if locale == I18n.default_locale
      "/"
    else
      "/#{locale.to_s}"
    end
  end

  def localized_href(href)
    "/#{locale_prefix}/#{href}".gsub(%r{/+}, "/")
  end

end


# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`

end
