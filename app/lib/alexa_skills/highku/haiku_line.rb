class HaikuLine #yes, I know how to spell Haiku

  class << self
    def create!(syllable_count)
      new(syllable_count).generate_line
    end
  end

  attr_reader :desired_syllables, :syllable_map, :markov_chain

  def initialize(desired_syllables, syllable_map, markov_chain)
    @desired_syllables = desired_syllables
    @syllable_map = syllable_map
    @markov_chain = markov_chain
  end

  def first_word
    syllable_map.syllable_search(desired_syllables)
  end

  def generate_line
    beginning = first_word
    remaining_syllables = desired_syllables - syllable_map[beginning]

    current_word = beginning

    until remaining_syllables == 0 do
      next_word = markov_chain.find_next(current_word)
      #if markov chain returns word(s) look through them for syllable <= remaining
      #if it finds none then we could either pick a new previous word or pick one
      # at random that fits syllable constraints
      if next_word
        current_word = next_word
        remaining_syllables -= syllable_map[current_word]
      end

      #use MarkovChain for first word
      #search syllable map for words with <= remaining_syllables
    end

  end


  #looks through wiki text to build requested syllable line
  #word to start line with possibly parse all of words that start a sentence in
  #input text. From there we will decrement the syllables of start word and begin to look in a range
  #i.e First word is Simple = 2 so with a desired syllable of 5 we have 3 left
  # the range we would begin to look in is from 1..3 possible recursive method where the range decrements each time
  #based on syllable found. If no markov chains are found for the word, then we should either find a new word, or
  #pick one at random that fits syllable constraints
end
