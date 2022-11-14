# -*- coding: utf-8 -*-
require 'slim'
Slim::Engine.disable_option_validator!
###
# Page options, layouts, aliases and proxies
###

set :encoding, 'utf-8'
set :index_file, 'index.html'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :host, 'https://www.kraiany.org'
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
default_language = :ja
supported_languages = [default_language, :en, :uk]
activate :i18n, langs: supported_languages, :mount_at_root => false

# --------------------------------------------
# Localization helpers
# --------------------------------------------
helpers do

  def current_language
    data.languages[I18n.locale]
  end

  def current_with_locale(locale)
    localised_path = current_page.url
      .sub(%r{^/#{I18n.locale}/},"/#{locale}/")
      .sub(%r{/$}, "/index.html")
    sitemap.find_resource_by_destination_path(localised_path) ? localised_path : "/#{locale}/"
  end

  def alternate_lang_pages(page)
    dict = {}

    data.languages.keys.map(&:to_sym).map do |locale|
      localised_path = page.url
        .sub(%r{^/#{I18n.locale}/},"/#{locale}/")
        .sub(%r{/$}, "/index.html")
      resource = sitemap.find_resource_by_destination_path(localised_path)
      dict[locale] = resource if resource
    end

    dict
  end

  def translated_title
    if current_page.data.title.present?
      title = if !current_page.data.title.match?(/[^A-Za-z0-9_\.]+/) && current_page.data.title.include?(".")
        t current_page.data.title
      else
        current_page.data.title
      end
      is_blog_article? ? [title, t("news.title")].join(" - ") : title
    else
      t(".title")
    end
  end

  def parse_date(c)
    c.class == Date ? c.to_date : Time.parse(c).to_date
  end
end

activate :sprockets
activate :blog do |blog|
  blog.default_extension = ".slim"
  blog.layout = "news"
  blog.permalink = "{lang}/news/{year}-{month}-{day}-{title}.html"
  blog.sources = "news/{year}-{month}-{day}-{lang}-{title}.html"
  blog.new_article_template = File.expand_path("source/news/article_template.tt", __dir__)

  blog.publish_future_dated = true
end

activate :sitemap, :hostname => "https://www.kraiany.org"


# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  set :host, 'http://localhost:4567'
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
  ignore(/^assets\/stylesheets\/(?!site).*\.css/)
  ignore(/^assets\/javascripts\/(?!site).*\.js/)
end

redirect "donate.html", to: "/#{default_language}/donate.html"
redirect "donate/index.html", to: "/#{default_language}/donate.html"
redirect "donate/manage.html", to: "https://billing.stripe.com/p/login/6oE6pY89Sap04uc000"
redirect "donate/report-sheet.html", to: "https://docs.google.com/spreadsheets/d/10DCYQGJ6pjHktbK3bHsT_5Wjy0dvPuKdlqWCi_HSip4/edit?usp=sharing"
redirect "news.html", to: "/#{default_language}/news.html"
redirect "news/index.html", to: "/#{default_language}/news.html"
redirect "parade.html", to: "/#{default_language}/parade.html"
redirect "parade/index.html", to: "/#{default_language}/parade.html"

# QR code landing pages printed on the flyers/banners
redirect "landing/1.html", to: "/#{default_language}/about.html"
redirect "landing/2.html", to: "/#{default_language}/about.html"
redirect "landing/3.html", to: "/#{default_language}/about.html"

supported_languages.each do |lang|
  redirect "#{lang}/parade/index.html", to: "/#{lang}/parade.html"
  redirect "#{lang}/news/index.html", to: "/#{lang}/news.html"
  redirect "#{lang}/news/2022-03-08-bankaccount.html", to: "/#{lang}/donate.html"
end
