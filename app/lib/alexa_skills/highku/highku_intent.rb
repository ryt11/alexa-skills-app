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

        CoherentHaiku.generate!(content)

        sc = SyllableCounter.new(content)
        x = sc.count_syllables('sobriquet')
        #counting syllables with about 90% accuracy fuck english
        #Class to use SyllableCounter to build 5|7|5 lines.
        #line class with syllable max as arg
        #once a line is created, there maybe some coherent sentence generator work
        #to ensure it makes some kind of sense
        #use markov chains to determine most likely next word, and search for needed syllable completion.
        #If nothing is found use a new word.
        #CoherentHaiku uses SyllableCounter to obtain map of words along with syllable count.
        #uses unmade MarkovChain to return hash with each word and their likely next follower(s)
        #uses line class to create each line in CoherentHaiku

      end
    end
  end
end
