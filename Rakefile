
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
    db1 = PetShop.create_db_connection('petshop_test')
    db2 = PetShop.create_db_connection('petshop_dev')
    PetShop.create_tables(db1)
    PetShop.create_tables(db2)
    puts "Created tables."
  end

  task :drop_tables => :environment do
    db1 = PetShop.create_db_connection('petshop_test')
    db2 = PetShop.create_db_connection('petshop_dev')
    PetShop.drop_tables(db1)
    PetShop.drop_tables(db2)
    puts "Dropped tables."
  end

  task :clear => :environment do
    # The test db clears all the time, so there's no point in doing it here.
    db = PetShop.create_db_connection('petshop_dev')
    db1 = PetShop.create_db_connection('petshop_test')
    PetShop.drop_tables(db)
    PetShop.drop_tables(db1)
    PetShop.create_tables(db)
    PetShop.create_tables(db1)
    puts "Cleared tables."
  end

  task :seed => :environment do
    db = PetShop.create_db_connection('petshop_dev')
    db1 = PetShop.create_db_connection('petshop_test')
    PetShop.seed_db(db)
    puts "Seeded."
  end

end
