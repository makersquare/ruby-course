require_relative '../lib/songify.rb'
require_relative 'server.rb'

Songify.songs_repo = Songify::Repo::Songs.new("songify_dev")
Songify.genres_repo = Songify::Repo::Genres.new("songify_dev")


run Songify::Server


