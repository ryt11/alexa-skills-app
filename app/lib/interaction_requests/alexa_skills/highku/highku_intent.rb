require_relative 'highku.rb'

module AlexaSkills::HighKu
  class Intent

    def initialize(origin_request)
      @wikipedia_connection ||= WikipediaService.new
      @origin_request = origin_request
    end


    class SpecifiedSeedWordIntent

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

      def fetch_wiki_response
        @wikipedia_connection.retrieve_page!(seed_word)
      end

      def process_response!
        wiki_response = fetch_wiki_response
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
