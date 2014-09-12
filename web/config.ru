require './server'
Songify::Repositories::Songs.new
Songify::Repositories::Genres.new
run Songify::Server