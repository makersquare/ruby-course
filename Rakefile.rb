task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end

namespace :db do

  task :create do
    #backticks--above the tilde--not single quotes: tells computer to execute that command
    puts `createdb songify_dev`
    puts `createdb songify_test`
    puts "Databases created."
  end

  task :migrate do
    require './lib/songify.rb'
    Songify::Repos::Genres.new('songify_test').build_table
    Songify::Repos::Genres.new('songify_dev').build_table
    Songify::Repos::Songs.new('songify_test').build_table
    Songify::Repos::Songs.new('songify_dev').build_table
    puts "Databases migrated."
  end

  task :drop do
    puts `dropdb songify_test`
    puts `dropdb songify_dev`
    puts "Databases dropped."
  end

end