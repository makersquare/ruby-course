
namespace :db do

  task :create do
    puts `createdb bookly_test`
    puts `createdb bookly_dev`
    puts "Databases created."
  end

  task :migrate do
    require './lib/bookly.rb'
    Bookly::Repositories::Books.new('bookly_test').create_tables
    Bookly::Repositories::Books.new('bookly_dev').create_tables
    puts "Databases migrated."
  end

  task :drop do
    puts `dropdb bookly_test`
    puts `dropdb bookly_dev`
    puts "Databases dropped."
  end

end

task :console do
  require './lib/bookly.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end
