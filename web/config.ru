require './server'

Songify.genres = Songify::Repos::Genres.new('songify_dev')

Songify.songs = Songify::Repos::Songs.new('songify_dev')

map "/public" do
 run Rack::Directory.new("./public")
end

run Songify::Server
