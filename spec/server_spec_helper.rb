require 'spec_helper.rb'
require './web/server.rb'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end