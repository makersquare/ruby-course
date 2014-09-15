require './web/server'
Songify.songs = Songify::Repositories::Songs.new
Songify.genres = Songify::Repositories::Genres.new
Songify::Repositories.adapter = 'songify_dev'
Songify::Repositories.build_tables
run Songify::Server