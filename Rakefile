task :environment do
  require './lib/chatitude'
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end

namespace :db do
  task :create do
    `createdb chatitude`
    puts 'Database \'chatitude\' created!'
  end

  task :drop do
    `dropdb chatitude`
    puts 'Database \'chatitude\' dropped!'
  end

  task :create_tables => :environment do
    db = Chatitude.create_db_connection 'chatitude'
    Chatitude.create_tables db
    puts 'Created tables.'
  end

  task :drop_tables => :environment do
    db = Chatitude.create_db_connection 'chatitude'
    Chatitude.drop_tables db
    puts 'Dropped tables.'
  end

  task :clear => :environment do
    db = Chatitude.create_db_connection 'chatitude'
    Chatitude.clear_tables db
    puts 'Cleared tables.'
  end

  task :seed => :environment do
    db = Chatitude.create_db_connection 'chatitude'
    Chatitude.seed_dummy_users db
    puts 'Tables seeded.'
  end
end
