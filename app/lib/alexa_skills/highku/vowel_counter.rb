class VowelCounter

  VOWELS = ['a', 'e', 'i', 'o', 'u'].freeze

  attr_reader :letters, :word
  attr_accessor :double_vowel_combinations

  def initialize(word)
    @word = word
    @letters = word.chars
    @double_vowel_combinations ||= []
  end

  def is_vowel?(letter)
    VOWELS.include?(letter)
  end

  def check_double_vowels(letter_combo)
    vowel_check = letter_combo.chars.map { |letter| is_vowel?(letter)}
    is_double = vowel_check.all?
    double_vowel_combinations << letter_combo if is_double
    is_double
  end

  def double_vowel_combos?
    !double_vowel_combinations.empty?
  end

  def vowel_add(letter)
    is_vowel?(letter) ? 1 : 0
  end

  def count_vowels
    letters.each_with_index.inject(0) do |vowel_count, (letter, index)|
      vowel_combo = index == 0 ? false : check_double_vowels(word[index - 1..index])
      count_result = vowel_combo ? 0 : vowel_add(letter)
      vowel_count += count_result
      vowel_count
    end
  end
end
