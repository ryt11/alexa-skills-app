module WikiApiPaths

  DEFAULT_FORMAT = 'json'.freeze
  DEFAULT_HTTP_VERB = :get
  BASE_PATH = 'https://en.wikipedia.org/w/api.php'
  MAX_CHARS = '500'
  EXTRACT_LIMIT = '10'

  class Page
    def self.content_fetch(page, format=nil)
      {
        action: 'query',
        prop: 'revisions',
        rvprop: 'content',
        format: format || DEFAULT_FORMAT,
        titles: page,
        exchars: MAX_CHARS,
        exintro: 'true',
        exlimit: EXTRACT_LIMIT,
        redirects: nil
      }
    end
  end
end
