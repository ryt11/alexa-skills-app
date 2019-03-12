require 'json'


class BaseRequest < ActiveRecord::Base
  attr_reader :parsed_interaction

  def initialize(interaction_request)
    @parsed_interaction = JSON.parse(interaction_request)
  end

  def interaction_name
    parsed_interaction['name']
  end

  def interaction_type
    parsed_interaction['type']
  end

  def interaction_slots
    parsed_interaction['slots']
  end

  def confirmation_status
    parsed_interaction['confirmationStatus']
  end
end
