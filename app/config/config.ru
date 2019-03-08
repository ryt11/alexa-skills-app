require 'rack'
require 'rack/contrib'
require 'sinatra/activerecord'

set :root, File.dirname(__FILE__)
set :intents, Proc.new { File.join(root, "intents") }
set :db_file, "../db/database.yaml"
set :environment, ENV['APP_ENV']

Dir["#{root}/**/*.rb"].each { |f| require(f) }

run Sinatra::Application
