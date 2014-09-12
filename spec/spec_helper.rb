require_relative '../lib/songify.rb'
require 'songify'
require 'pry-byebug'


Songify.genres_repo = Songify::Repositories::Genres.new('songify_test')
Songify.songs_repo = Songify::Repositories::Songs.new('songify_test')


RSpec.configure do |config|
  config.before(:each) do
    Songify.genres_repo.truncate_table
  end
end
