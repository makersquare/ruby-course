require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'pry-byebug'

class Songify::Server < Sinatra::Application

set :bind, '0.0.0.0'

  get '/' do 
    @songs = Songify.songs_repo.get_all_songs
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
    song_title = params['title']
    song_artist = params['artist']
    song_album = params['album']
    x = Songify::Song.new(song_title, song_album, song_artist)
    Songify.songs_repo.save_a_song(x)
    redirect to('/index') 
  end



run! if __FILE__ == $0

end