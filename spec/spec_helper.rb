# Require our project, which in turns requires everything else
require './lib/task-manager.rb'

RSpec.configure do |config|
  # Configure each test to always use a new singleton instance
  config.before(:each) do
    TM.instance_variable_set(:@__database, nil)
  end
end
