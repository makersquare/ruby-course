# Require our project, which in turns requires everything else
require './lib/task-manager.rb'
require 'pry-debugger'
require 'time'

# this configures rspec so that each test gets a newly created singleton instance
RSpec.configure do |config|
  # Reset singleton instance before every test
  config.before(:each) do
    Singleton.__init__(TM::DB)
  end
end
