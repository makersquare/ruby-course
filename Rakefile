namespace :db do

  task :create do
    puts `createdb songify_test`
    puts `createdb songify_dev`
    puts "Databases created."
  end

  task :drop do
    puts `dropdb songify_test`
    puts `dropdb songify_dev`
    puts "Databases dropped."
  end

end

task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end