require './server'

Songify.genres = Songify::Repos::Genres.new('songify_dev')

Songify.songs = Songify::Repos::Songs.new('songify_dev')

run Songify::Server












