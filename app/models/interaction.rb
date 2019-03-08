class IntentRequest < ActiveRecord::Base

  def initialize(intent_request)
    @attributes = intent_request['attributes']
  end
end
