require 'rspec'
require 'pry-byebug'

require_relative '../lib/songify.rb'

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs.delete_all
  end
end
