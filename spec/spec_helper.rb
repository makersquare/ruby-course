require 'honkr'
require 'pry-byebug'

RSpec.configure do |config|
  config.before(:each) do
    Honkr.instance_variable_set(:@__db_instance, nil)
    allow_message_expectations_on_nil
  end
end
