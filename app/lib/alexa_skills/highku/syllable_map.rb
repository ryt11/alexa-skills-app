require_relative 'highku.rb'


module AlexaSkills::HighKu


  class SyllableMap < Hash


    def words
      keys
    end

    def syllable_search(syllable_count)
      select { |word, syllables| syllables == syllable_count}
    end
  end
end
