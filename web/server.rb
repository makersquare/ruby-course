require_relative '../lib/songify.rb'
require 'sinatra/base'



class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'
  
  get '/' do
   erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs
    erb :show
  end

  get '/new' do
    erb :new
  end

  post '/create' do 
    song = Songify::Song.new(params["song_title"], params["song_artist"], params["song_album"])
    Songify.songs_repo.save_song(song)
    song.title
  end
  run! if __FILE__ == $0
end