require_relative 'highku.rb'
require_relative '../../concerns/html_parser.rb'

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
        #classes that will strip/sanitize html, this could be added as a class method
        # at HighKu level or into a module.
        #classes to utilize syllable counting gems
        #classes to utilize csg
        #class to join the two. CoherentHaiku
        # each instance of Intent::SpecifiedSeedWordIntent should have a memoized
        # wiki connection to access, or any class instantiated under ::Intent
        #includes: syllable counting, coherent sentence generator, and calls to
        # existing wiki service
      end
    end
  end
end
