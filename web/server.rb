require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.show_all_songs
    erb :show
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    # create a new song based on input parameters
    song = Songify::Song.new(params["song-title"],params["song-artist"],params["song-album"],params["song-genre"])
    # save song & grab the title
    Songify.songs_repo.save_a_song(song)
    # song.title
    redirect to '/show'
  end

  run! if __FILE__ == $0
end