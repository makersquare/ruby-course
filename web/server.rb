require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
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
    song = Songify::Song.new(params["song_title"],params["song_artist"],params["song_album"],params["song_genre"])
    # save song & grab the title
    Songify.songs_repo.save_a_song(song)
    song.title
  end
end