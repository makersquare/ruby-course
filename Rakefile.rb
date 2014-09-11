task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end

namespace :db do

  task :create do
    #backticks--above the tilde--not single quotes: tells computer to execute that command
    puts `createdb songify`
    puts "Database created."
  end

  task :migrate do
    require './lib/songify.rb'
    Songify::Repos::Songs.new('songify').build_table
    puts "Database migrated."
  end

  task :drop do
    puts `dropdb songify`
    puts "Database dropped."
  end

end