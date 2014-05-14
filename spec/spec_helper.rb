require 'pry'
require './lib/tweet.rb'
include Tweet

RSpec.configure do |config|
  config.before(:each) do
    Tweet.instance_variable_set(:@__db_instance, nil)
  end
end
