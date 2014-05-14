require './lib/quackquack.rb'

RSpec.configure do |config|
  config.before(:each) do
    TM.instance_variable_set(:@__db_instance, nil)
  end
end
