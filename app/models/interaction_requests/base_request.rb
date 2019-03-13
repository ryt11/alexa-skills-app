require 'pry'

class BaseRequest

  attr_reader :interaction

  def initialize(interaction)
    @interaction = interaction
  end

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

  def skill_name
    $SKILL_MAPPING[skill_id]
  end
end
