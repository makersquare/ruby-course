
namespace :db do

 task :console do
   require './lib/songify.rb'
   require 'irb'
   ARGV.clear
   IRB.start
 end

  task :create do
    puts `createdb songify`
    puts "Databases created."
  end

  task :drop do
    puts `dropdb songify`
    puts "Databases dropped."
  end

  task :migrate do
    require './lib/songify.rb'
    Songify::Repositories::Songs.new('songify').build_tables
    Songify::Repositories::Genres.new('songify').build_tables
    puts "Databases migrated."
  end

end