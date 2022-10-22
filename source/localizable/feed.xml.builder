xml.instruct!
  xml.feed "xmlns" => "https://www.w3.org/2005/Atom" do
  xml.title t("news.title")
  xml.subtitle [t("news.sub_title"), t("kraiany.about")].join(". ")
  xml.id [config[:host], lang, "news.html"].join(?/)
  xml.link "href" => [config[:host], lang, "news.html"].join(?/)
  xml.link "href" => [config[:host], lang, "feed.xml"].join(?/), "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name t("kraiany.author") }

  blog.articles_by_locale[0..10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => [config[:host],article.url].join
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name t("kraiany.author") }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
