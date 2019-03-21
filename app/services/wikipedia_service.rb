require 'json'
require 'pry'
class WikipediaService < BaseService
  #when calling method including connection use httprequestinteractor
  #class to immediately forward
  include WikiApiPaths

  attr_reader :base_connection

  def initialize
    @base_connection = Faraday.new(WikiApiPaths::BASE_PATH)
  end

  def page_connection(page_name, extended_url_path=nil)
      params = WikiApiPaths::Page.content_fetch(page_name)
      base_connection.build_url(extended_url_path, params )
  end

  def retrieve_page!(page_name)
    uri = page_connection(page_name)
    binding.pry
    response = send!(WikiApiPaths::DEFAULT_HTTP_VERB, uri)
    parse(response.body)
  end
end
