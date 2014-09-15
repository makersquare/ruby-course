namespace :db do

  task :create do
    puts `createdb songs`
    puts "Database created."
  end

  task :migrate do
    require './lib/sonify.rb'
    Songify::Repositories::Song_Repo.new.build_table
    puts "Database migrated."
  end

  task :drop do
    puts `dropdb songs`
    puts "Database dropped."
  end

end

task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end