require 'songify'
Songify.genres_repo = Songify::Repositories::Genres.new('songify_test')
Songify.songs_repo = Songify::Repositories::Songs.new('songify_test')

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.delete_all
  end
end