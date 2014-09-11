require_relative '../lib/songify.rb'
require 'spec_helper'
require './server/server.rb'
require 'rack/test'


RSpec.configure do |config|
  config.include Rack::Test::Methods
end