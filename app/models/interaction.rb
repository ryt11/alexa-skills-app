require 'json'
require 'pry'
class Interaction

  TYPES = ["LaunchRequest", "IntentRequest", "SessionEndedRequest" ].freeze

  attr_reader :interaction, :interaction_type, :interaction_request

  def initialize(interaction)
    @interaction = JSON.parse(interaction)
    @interaction_type = @interaction['request']['type']
  end

  def intent_request
    IntentRequest.new(interaction).process_response!
  end

  def launch_request
    raise 'Not Implemented Yet'
  end

  def session_ended_request
    raise 'Not Implemented Yet'
  end

  def determine_interaction
    found_type = Interaction::TYPES.select { |type| interaction_type == type }
    found_type.count == 1 or raise "Only one type allowed per request. Response included: #{interaction}."
    send methodize(found_type.first)
  end

  def methodize(found_type)
    split_by_capitals = found_type.split /(?=[A-Z])/
    split_by_capitals.map { |type| type.downcase }.join('_').to_sym
  end

end
