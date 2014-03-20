# Require our project, which in turns requires everything else
require './lib/task-manager.rb'
require 'pry-debugger'

RSpec.configure do |config|
  config.before(:each) do
    Singleton.__init__(TM::DB)
  end
end
