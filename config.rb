# -*- coding: utf-8 -*-
require 'slim'
Slim::Engine.disable_option_validator!
###
# Page options, layouts, aliases and proxies
###

set :encoding, 'utf-8'
set :index_file, 'index.html'
set :partials_dir, 'partials'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
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

activate :i18n, langs: [:ja, :en, :uk], :mount_at_root => false
activate :directory_indexes

# --------------------------------------------
# Localization helpers
# --------------------------------------------
helpers do

  def current_language
    data.languages[I18n.locale]
  end

  def current_with_locale(locale)
    current_page_with_locale
      .url
      .sub(%r{^/#{I18n.locale}/},"/#{locale}/")
  end
end

activate :sprockets

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  activate :relative_assets
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
  activate :minify_css
  activate :minify_javascript
  set :relative_links, true

  # somehow minifying html takes some html attributes away so it is causing
  # some css not applied to certain elements... so until we find alternative
  # way to monify html, we will disable this
  activate :minify_html do |html|
    html.remove_multi_spaces        = true   # Remove multiple spaces
    html.remove_comments            = true   # Remove comments
    html.remove_intertag_spaces     = false  # Remove inter-tag spaces
    html.remove_quotes              = true   # Remove quotes
    html.simple_doctype             = false  # Use simple doctype
    html.remove_script_attributes   = false   # Remove script attributes
    html.remove_style_attributes    = false   # Remove style attributes
    html.remove_link_attributes     = false   # Remove link attributes
    html.remove_form_attributes     = false  # Remove form attributes
    html.remove_input_attributes    = false   # Remove input attributes
    html.remove_javascript_protocol = false   # Remove JS protocol
    html.remove_http_protocol       = false   # Remove HTTP protocol
    html.remove_https_protocol      = false  # Remove HTTPS protocol
    html.preserve_line_breaks       = false  # Preserve line breaks
    html.simple_boolean_attributes  = true   # Use simple boolean attributes
  end
  activate :asset_hash, :ignore => [/fonts/, /favicon.png/]
  activate :gzip
  ignore '*.less'
  ignore '*_template.*'
  ignore(/Icon\r$/)
  ignore(/\.DS_Store/)
  ignore(/^assets.*\.yml/)
  ignore(/^assets\/stylesheets\/(?!all).*\.css/)
  ignore(/^assets\/javascripts\/(?!all).*\.js/)
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`

end
