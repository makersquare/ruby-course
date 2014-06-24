require 'honkr'
require 'pry-byebug'

RSpec.configure do |config|
  config.before(:each) do
    Honkr.instance_variable_set(:@__db_instance, nil)
  end
end
