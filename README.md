bundle exec rake db:create
bundle exec rake db:create_tables
bundle exec rake db:seed

bundle exec rspec

bundle exec rackup -p 4567
