require_relative 'highku.rb'

module AlexaSkills::HighKu
  class Intent

    def initialize(origin_request)
      @wikipedia_connection ||= WikipediaService.new
      @origin_request = origin_request
    end


    class SpecifiedSeedWordIntent < Intent

      SLOT_NAME = "SeedWord".freeze

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

      def fetch_wiki_response
        @wikipedia_connection.return_page_data!(seed_word)
      end

      def process_response!
        wiki_response = fetch_wiki_response
        page_title = wiki_response[:title]
        content = wiki_response[:content]

        sc = SyllableCounter.new(content)
        x = sc.count_syllables('sobriquet')
        #counting syllables with about 90% accuracy fuck english
      
      end
    end
  end
end
