require 'pry'
class HtmlParser

  class << self
    def parse!(html_blob)
      doc = Nokogiri::HTML(html_blob)
      binding.pry
    end
  end

end
