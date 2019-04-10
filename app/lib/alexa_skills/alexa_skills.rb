require_relative 'highku/highku.rb'
require 'pry'

module AlexaSkills

  PARENT_MODULE = Module.nesting.last

  class << self
    def interact!
      interaction = Interaction.new(test)
      interaction.respond
    end

    def test
      File.read("./spec/captured_alexa_requests/intent_request_one_slot.json")
    end
  end
end
