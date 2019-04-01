require 'pry'

module HtmlParser

  def html_parse(html_blob)
    doc = Nokogiri::HTML(html_blob)
  end
end
