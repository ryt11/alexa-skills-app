class Interaction

  TYPES = ["LaunchRequest", "IntentRequest", "SessionEndedRequest" ].freeze

  attr_reader :interaction_type, :interaction_request

  def initialize(interaction_request)
    @interaction_request = interaction_request
    @interaction_type = interaction_request['request']['type']
  end

  def determine_interaction
    found_type = Interaction::TYPES.select { |type| interaction_type == type }
    found_type.count == 1 or Raise "Only one type allowed per request. Response included: #{interaction_request}."
    send methodize(found_type.first)
  end

  def methodize(found_type)
    split_by_capitals = found_type.split /(?=[A-Z])/
    split_by_capitals.map { |type| type.downcase }.join('_').to_sym
  end


  def intent_request
    IntentRequest.process_response(interaction_request)
  end

  def launch_request
    "Not Implemented Yet"
  end

  def session_ended_request
    "Not Implemented Yet"
  end

end
