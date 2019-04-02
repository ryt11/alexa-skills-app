require 'json'
require_relative '../base_service.rb'

class WikipediaService < BaseService
  #when calling method including connection use httprequestinteractor
  #class to immediately forward
  include WikiApiPaths

  attr_reader :base_connection

  def initialize
    @base_connection = Faraday.new(WikiApiPaths::BASE_PATH)
  end

  def page_connection(title_name, extended_url_path=nil)
      params = WikiApiPaths::Page.content_fetch(title_name)
      base_connection.build_url(extended_url_path, params )
  end

  def parse_page(response_body)
    parse(response_body)['query']['pages']
  end

  def return_page_data!(title_name)
    uri = page_connection(title_name)
    response = send!(WikiApiPaths::DEFAULT_HTTP_VERB, uri)
    parsed = parse_page(response.body)
    WikipediaPage.new(parsed).encompassed_data
  end
end
