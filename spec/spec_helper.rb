require 'rspec'
require 'pry-byebug'
require_relative "../lib/songify.rb"

Songify.songs_repo = Songify::Repos::Songs.new('songify_test')
Songify.genres_repo = Songify::Repos::Genres.new('songify_test')

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
  end
end
