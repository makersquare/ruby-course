require './lib/quack.rb'
include Quack

RSpec.configure do |config|
  config.before(:each) do
    Quack.instance_variable_set(:@__db_instance, nil)
  end
end
