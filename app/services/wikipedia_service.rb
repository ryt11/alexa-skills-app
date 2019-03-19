require 'json'

class WikipediaService < BaseService
  #when calling method including connection use httprequestinteractor
  #class to immediately forward
  include WikiApiPaths

  def initialize
    @base_connection = Faraday.new("https://en.wikipedia.org/w/api.php")
  end

  def page_connection(page_name:, extended_url_path:)
      params = WikiApiPaths::Page.content_fetch(page_name)
      base_connection.build_url(extended_url_path || nil, params )
  end

  def retrieve_page!(page_name)
    response = page_connection.send(WikiApiPaths::DEFAULT_HTTP_VERB)
    parse(response.body)
    #TODO: Error handling for http responses
  end

  #use exclamation to signify action methods which will have callback
  #t forward httpconnection and parse response using httprequestinteractor class
end
