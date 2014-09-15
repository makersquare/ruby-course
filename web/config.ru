require './server'

Songify.songs_repo = Songify::Repositories::Songs.new('songify_dev')
Songify.genres_repo = Songify::Repositories::Genres.new('songify_dev')

run Songify::Server