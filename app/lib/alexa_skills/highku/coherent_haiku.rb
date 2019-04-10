class CoherentHaiku

  SYLLABLE_SEQUENCE = [5, 7, 5].freeze

  class << self
    def generate!(content)
      new(content).construct_haiku
    end
  end

  attr_reader :content

  def initialize(content)
    @content = content
  end

  def construct_haiku
    SYLLABLE_SEQUENCE.inject([]) do |haiku, syllable_count|
      haiku << HaikuLine.create!(syllable_count, syllable_map, markov_chain)
    end
  end

  def markov_chain
    @markov_chain ||= MarkovChain.generate!(content)
  end

  def syllable_map
    @syllable_map ||= SyllableCounter.generate_syllable_map!(content)
  end
end
