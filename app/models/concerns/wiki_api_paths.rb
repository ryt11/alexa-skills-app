module WikiApiPaths

  DEFAULT_FORMAT = 'json'.freeze
  DEFAULT_HTTP_VERB = :get
  #This service only utilizes get verbs to fetch content

    def self.content_fetch(page: ,format:)
      {
        action: 'parse',
        prop: 'text',
        format: format || DEFAULT_FORMAT,
        page: page
      }
  end
end
