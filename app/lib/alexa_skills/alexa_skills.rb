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


# def get_intent_module
#   binding.pry
#   skill_module  = "#{BASE_MODULE}::#{skill_name}::#{MODULE_NAME}::#{intent_name}"
#   identify_constant(skill_module)
# end
#
# def process_response!
#   # self.class.send :include, identify_constant("#{BASE_MODULE}::#{skill_name}::#{MODULE_NAME}")
#   request_class.new(self).prepare_response
# end
#
# def identify_constant(constant_name)
#   Kernel.const_get(constant_name) if Kernel.const_defined?(constant_name)
# end
