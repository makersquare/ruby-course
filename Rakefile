
task :environment do
  require './lib/petshop.rb'
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end


namespace :db do

  task :create do
    `createdb petshop_dev`
    `createdb petshop_test`
    puts "Created."
  end

  task :drop do
    `dropdb petshop_dev`
    `dropdb petshop_test`
    puts "Dropped."
  end

  task :create_tables => :environment do
    db2 = Petshop.create_db_connection('petshop_dev')
    Petshop.create_tables(db2)
    puts "Created tables."
  end

  task :drop_tables => :environment do
    db2 = Petshop.create_db_connection('petshop_dev')
    Petshop.drop_tables(db2)
    puts "Dropped tables."
  end

  task :clear => :environment do
    # The test db clears all the time, so there's no point in doing it here.
    db = Petshop.create_db_connection('petshop_dev')
    Petshop.drop_tables(db)
    Petshop.create_tables(db)
    puts "Cleared tables."
  end

  task :seed => :environment do
    db = Petshop.create_db_connection('petshop_dev')
    Petshop.seed_db(db)
    puts "Seeded."
  end

end
