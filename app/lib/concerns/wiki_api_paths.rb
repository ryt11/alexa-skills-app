module WikiApiPaths

DEFAULT_HTTP_VERB = :get

BASE_PATH = 'https://en.wikipedia.org/w/api.php'

WIKI_PAGE_PARAMS =

{
    action: 'query',
    prop: 'extracts',
    format: 'json',
    exchars: '1200',
    exintro: 'true',
    exlimit: '1',
    explaintext:  nil,
    redirects: nil

  }

  class Page
    class << self

      def titles_param(page)
        {
          titles: page
         }
      end

      def content_fetch(page)
        WIKI_PAGE_PARAMS.merge!(titles_param(page))
      end
    end
  end
end
