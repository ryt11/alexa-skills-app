require 'pry'
require_relative 'intent_request.rb'

module HighKu
  class Intents
    def initialize
      @wikipedia_connection ||= WikipediaService.new
    end
    class SpecifiedSeedWordIntent
      #This class will use helpers to build a coherent haiku
      
      def prepare_response
        parsed_wiki_page = @wikipedia_connection.retrieve_page!(seed_word)
      end
    end
  end
end
