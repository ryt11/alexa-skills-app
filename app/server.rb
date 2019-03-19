require 'json'
require 'pry'

class AlexaSkillApp < Sinatra::Base

set :app_file, __FILE__

  before do
    if request.body.size > 0
      request.body.rewind
      @params = Sinatra::IndifferentHash.new
      @params.merge!(JSON.parse(request.body.read))
    end
  end

  post '/' do
    Interaction.new(test).determine_interaction
  end

  def test
    File.read("#{settings.root}/spec/captured_alexa_requests/intent_request_one_slot.json")
  end
end
