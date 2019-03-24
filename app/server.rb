require 'json'
require 'pry'

class AlexaSkillApp < Sinatra::Base

include AlexaSkills

set :app_file, __FILE__

  before do
    if request.body.size > 0
      request.body.rewind
      @params = Sinatra::IndifferentHash.new
      @params.merge!(JSON.parse(request.body.read))
    end
  end

  post '/' do
    AlexaSkills.interact!
  end


end
