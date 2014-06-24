require 'honker'
require 'pry-byebug'

RSpec.configure do |config|
  config.before(:each) do
    Honker.instance_variable_set(:@__db_instance, nil)
  end
end
