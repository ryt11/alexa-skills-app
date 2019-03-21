require 'pry'

class BaseRequest

  attr_reader :interaction

  def initialize(interaction)
    @interaction = interaction
  end

  class SkillModuleNotDefined < StandardError; end

  def interaction_request
    interaction['request']
  end

  def interaction_type
    interaction_request['type']
  end

  def session
    interaction['session']
  end

  #includes user and skill id data
  def application
    session['application']
  end

  def skill_id
    application['applicationId']
  end

  def identify_constant(constant_name)
    Kernel.const_get(constant_name) if Kernel.const_defined?(constant_name)
  end

  def skill_name
    $SKILL_MAPPING[skill_id]
  end
end
