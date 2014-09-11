require './server'
Songify.songs_repo = Songify::Repositories::Songs.new('songify_dev')
run Songify::Server