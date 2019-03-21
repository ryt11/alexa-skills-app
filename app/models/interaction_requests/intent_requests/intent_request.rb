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

  def request_class
    skill_module = "#{skill_name}::Intents::#{intent_name}"
    get_skill_module(skill_module)
  end

  def get_skill_module(skill_module)
    identify_constant(skill_module)
  end

  def process_response!
    self.class.send :include, identify_constant(skill_name)
    request_class.new(self).prepare_response
  end

end
