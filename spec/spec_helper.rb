# Require our project, which in turns requires everything else
require './lib/task-manager.rb'
require 'time'

RSpec.configure do |config|
  # Configure each test to always use a new singleton instance
  config.before(:each) do
    TM.instance_variable_set(:@db_instance, nil)
  end
end
