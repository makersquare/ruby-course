require './server'

Songify::Repos::Songs.new('songify_dev')
Songify::Repos::Genres.new('songify_dev')

run Songify::Server