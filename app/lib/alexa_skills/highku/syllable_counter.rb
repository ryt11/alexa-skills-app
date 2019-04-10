require_relative 'highku.rb'

module AlexaSkills::HighKu

  class SyllableCounter

    EXEMPT_VOWEL_COMBINATIONS = ['ia' ].freeze
    NEGATION_ENDINGS = ['es', 'e'].freeze

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

    def exempt_vowel_combo?(vowel_combo)
      EXEMPT_VOWEL_COMBINATIONS.include?(vowel_combo)
    end

    #perhaps break out negation score determination to class which will just return score to remove from vowel count

    def negation_score(word, vowel_counter)

      neg_score = 0

      if vowel_counter.double_vowel_combos?
        if vowel_combo_negation = vowel_counter.double_vowel_combinations.inject(0) { |negate_score, vowel_combo| negate_score += 1 if exempt_vowel_combo?(vowel_combo) }
          neg_score += vowel_combo_negation
        end
      end

      neg_score -= 1 if negate_silent?(word)
      neg_score
    end

    def negate_silent?(word)
      return false unless word.length > 3
      letters = word.chars
      NEGATION_ENDINGS.include?(letters.last) || NEGATION_ENDINGS.include?(letters.last(2).join)
    end

    def exempt_vowel_combo?(letter_combination)
      EXEMPT_VOWEL_COMBINATIONS.include?(letter_combination)
    end

    def populate_syllable_map
      word_list.each do |word|
        syllables = one_syllable?(word) ? 1 : count_syllables(word)
        syllable_map[word] = syllables
      end
    end

    def count_syllables(word)
      vowel_counter = VowelCounter.new(word)
      vowel_count = vowel_counter.count_vowels
      vowel_count += negation_score(word, vowel_counter)
      vowel_count
    end
  end
end
