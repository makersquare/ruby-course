require 'spec_helper'
require_relative '../web/server.rb'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end