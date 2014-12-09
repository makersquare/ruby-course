
task :environment do
  require './lib/songify.rb'
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end


namespace :db do

  task :create do
    `createdb songify_test`
    `createdb songify_dev`
    puts "Created."
  end

  task :drop do
    `dropdb songify_test`
    `dropdb songify_dev`
    puts "Dropped."
  end

  task :create_tables => :environment do
    db1 = Songify.create_db_connection('songify_test')
    db2 = Songify.create_db_connection('songify_dev')
    Songify.create_tables(db1)
    Songify.create_tables(db2)
    puts "Created tables."
  end

  task :drop_tables => :environment do
    db1 = Songify.create_db_connection('songify_test')
    db2 = Songify.create_db_connection('songify_dev')
    Songify.drop_tables(db1)
    Songify.drop_tables(db2)
    puts "Dropped tables."
  end

  task :clear => :environment do
    # The test db clears all the time, so there's no point in doing it here.
    db = Songify.create_db_connection('songify_dev')
    Songify.drop_tables(db)
    puts "Cleared tables."
  end

end
