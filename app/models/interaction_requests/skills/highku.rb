require 'pry'

module HighKu


  class Intents
    def initialize(origin_request)
      @wikipedia_connection ||= WikipediaService.new
      @origin_request = origin_request
    end


    class SpecifiedSeedWordIntent < Intents

      SLOT_NAME = "SeedWord".freeze


      def initialize(origin_request)
        super
      end

      def slot_data
        @slot_data ||= @origin_request.slots[SLOT_NAME]
      end

      def seed_word
        slot_data['value']
      end

      def confirmation_status
        slot_data['confirmationStatus']
      end

      def source
        slot_data['USER']
      end
      #This class will use helpers to build a coherent haiku
      #The Intent Request will handle the actual processing of http req

      def prepare_response
        binding.pry
        parsed_wiki_page = @wikipedia_connection.retrieve_page!(seed_word)
      end
    end
  end
end
