require_relative 'highku.rb'

module AlexaSkills::HighKu

  class SyllableCounter

    VOWELS = ['a', 'e', 'i', 'o', 'u'].freeze

    attr_accessor :syllable_map
    attr_reader :word_list

    def initialize(text)
      @syllable_map = SyllableMap.new
      #remove non-alphanumeric characters, excluding spaces
      @text = text.downcase.gsub!(/[^a-z0-9\s]/i, '')
      @word_list = @text.split
    end

    def one_syllable?(word)
      word.length <= 2
    end

    def negate_silent?(word)
      return false unless word.length > 3
      word [-2..-1] == 'es' || word[-1] == 'e'
    end

    def populate_syllable_map
      word_list.each do |word|
        syllables = one_syllable?(word) ? 1 : count_syllables(word)
        syllable_map[word] = syllables
      end
    end


    #when iterating through word, search ahead with index to see if there are
    #two vowels in a row. If so, then add one syllable and skip the next letter by increasing
    #index words like inadequate

    #review entire algorithm

    def count_syllables(word)
      vowel_count = count_vowels(word)
      vowel_count -= 1 if negate_silent?(word)
      vowel_count
    end


    def count_vowels(word)
      num_vowels = 0
      last_was_vowel = false
      found_vowel = false


      word.chars.each do |letter|
        last_was_vowel = found_vowel
        VOWELS.each do |v|
          if v == letter
            num_vowels += 1 if !last_was_vowel
            found_vowel = true
            break
          end
          found_vowel = false
        end
      end

      num_vowels
    end
  end
end
