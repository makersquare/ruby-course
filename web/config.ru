require './server'
Songify.songs_repo = Songify::Repositories::Songs.new('songify_dev')
Songify.songs_repo.drop_table

run Songify::Server