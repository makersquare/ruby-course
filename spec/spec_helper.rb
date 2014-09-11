require_relative "../lib/songify.rb"

Songify.songs_repo = Songify::Repo::Songs.new("songify_test")
Songify.genres_repo = Songify::Repo::Genres.new("songify_test")


RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.drop_table
  end
end