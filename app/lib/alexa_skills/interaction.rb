require 'json'
require_relative 'alexa_skills'
require 'pry'
module AlexaSkills
  class Interaction

    TYPES = ["LaunchRequest", "IntentRequest", "SessionEndedRequest" ].freeze

    attr_reader :interaction, :interaction_type, :interaction_request

    def initialize(interaction)
      @interaction = JSON.parse(interaction)
      @interaction_type = @interaction['request']['type']
    end

    def respond
      interaction_class.process_response!
    end

    def intent
      intent_request = IntentRequest.new(interaction)

      type_class = __method__.to_s.capitalize
      skill_name = intent_request.skill_name
      intent_name = intent_request.intent_name

      const_suffix = "#{skill_name}::#{type_class}::#{intent_name}"

      intent_class = PARENT_MODULE.const_get(const_suffix)
      intent_class.new(intent_request)
    end

    def launch
      raise 'Not Implemented Yet'
    end

    def session
      raise 'Not Implemented Yet'
    end

    def valid_interaction_type?
      received_type = interaction_type
      found_type = TYPES.select { |type| type == received_type }
      found_type.count == 1 or raise "Only one type allowed per request. Response included: #{interaction}."
    end

    def interaction_class
      method = methodize(interaction_type) if valid_interaction_type?
      send method
    end

    def methodize(string)
      string.split_by_capitals.first.downcase.to_sym
    end
  end
end
