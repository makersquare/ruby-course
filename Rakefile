namespace :db do

  task :create do
    puts `createdb songify_test`
    puts `createdb songify_dev`
    puts "Databases created"
  end

  task :migrate do
    require './lib/songify.rb'
    Songify::Repositories.build_tables
    puts "Databases migrated"
  end

  task :drop do
    puts `dropdb songify_test`
    puts `dropdb songify_dev`
    puts "Databases dropped"
  end

  task :console do
    require './lib/songify.rb'
    require 'irb'
    ARGV.clear
    IRB.start
  end

end