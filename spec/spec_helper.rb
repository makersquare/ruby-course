# Require our project, which in turns requires everything else
require './lib/task-manager.rb'
require 'pry-debugger'
require 'time'

# Set our database class to use a test database.
# Any code that requires our business logic NEEDS to set a database name like this.
# For example, a Terminal client would need to specify which db file it wants to save/read data to/from.
TM.db_name = 'tm_test.db'

RSpec.configure do |config|
  # Configure each test to always use a new singleton instance
  config.before(:each) do
    TM.instance_variable_set(:@__db_instance, nil)

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # NEW: This clears your tables so you get fresh tables for every test
    # Please READ THE METHOD yourself in database.rb
    TM.db.clear_all_records
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  end
end
