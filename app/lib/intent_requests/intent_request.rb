require 'pry'

class IntentRequest < BaseRequest

  def initialize(interaction_request)
    super
  end

  def intent
    interaction_request['intent']
  end

  def intent_name
    intent['name']
  end

  def slots
    intent['slots']
  end
end
