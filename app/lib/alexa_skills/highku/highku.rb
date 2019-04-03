require_relative 'highku_intent.rb'
require_relative '../alexa_skills.rb'

module AlexaSkills::HighKu

  class SyllableCounter

    VOWELS = ['a', 'e', 'i', 'o', 'u'].freeze

    attr_accessor :syllable_map
    attr_reader :word_list

    def initialize(text)
      @syllable_map = Hash.new(0)
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

    def count_syllables(word)
      num_vowels = 0
      last_was_vowel = false
      found_vowel = false

      word.chars.each do |letter|

        VOWELS.each do |v|
          if v == letter
            binding.pry
            num_vowels += 1 unless last_was_vowel
            found_vowel, last_was_vowel = true
            break
          end
          last_was_vowel = false unless found_vowel
        end
      end
      num_vowels -= 1 if negate_silent?(word)
      num_vowels
    end
  end
end
