require_relative 'highku.rb'
require 'pry'


class IntentRequest < BaseRequest
 include HighKu


  def initialize(interaction_request)
    super
  end

  def intent_name
    interaction_request['intent']['name']
  end

  def request_class
    skill_module = "#{skill_name}::#{intent_name}"
    Kernel.const_get(skill_module) if Kernel.const_defined?(skill_module)
  end


  def process_response!
    request_class.new(interaction_request).respond!
  end

end
