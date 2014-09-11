require_relative '../lib/songify.rb'
require 'songify'

Songify::Repositories.adapter = 'songify_test'
Songify.songs = Songify::Repositories::Songs.new
Songify.genres = Songify::Repositories::Genres.new


RSpec.configure do |config|
  config.before(:each) do
    Songify::Repositories.drop_tables
    Songify::Repositories.build_tables
  end
end