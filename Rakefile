require 'rspec/core/rake_task'
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./app"
  end
end

RSpec::Core::RakeTask.new :specs do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end

task :default => ['specs']
