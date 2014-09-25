require 'rspec'
require 'pry-byebug'
require_relative '../lib/songify.rb'

Songify.genres = Songify::Repos::Genres.new('songify_test')
Songify.songs = Songify::Repos::Songs.new('songify_test')

RSpec.configure do |config|
  config.before(:each) do
    Songify.genres.delete_all
    Songify.songs.delete_all
  end
end

