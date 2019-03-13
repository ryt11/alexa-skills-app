require 'pry'
require_relative '../base_request.rb'

module HighKu
  class SpecifiedSeedWordIntent < BaseRequest

    def initialize(interaction_request)
      super
    end

    def respond!
      binding.pry
      puts "sardsdd"
    end
  end
end
