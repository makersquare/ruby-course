
task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end

task :db_create do 
  `createdb songify-dev` # runs in terminal
  `createdb songify-test`
  puts "databases created"
end

task :db_drop do 
  `dropdb songify-dev` # runs in terminal
  `dropdb songify-test`
  puts "databases dropped"
end


# bundle exec rake db_create