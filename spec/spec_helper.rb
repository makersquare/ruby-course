require 'songify'
Songify.songs_repo = Songify::Repositories::Songs.new('songify_test')

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs_repo.truncate_song
  end
end