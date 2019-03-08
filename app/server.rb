require 'sinatra'
require 'aws-record'

before do
  if request.body.size > 0
    request.body.rewind
    @params = Sinatra::IndifferentHash.new
    @params.merge!(JSON.parse(request.body.read))
  end
end

get '/' do
  Interaction.new(@params)
end
