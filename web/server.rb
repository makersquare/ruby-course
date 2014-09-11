require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs

    erb :show
  end

  post '/show' do
    @songs = Songify.songs_repo.get_all_songs

    erb :show
  end

  get '/new' do
    erb :new
  end


  post '/create' do
    song = Songify::Song.new(params["title"], params["artist"], params["album"])
    Songify.songs_repo.save_a_song(song)
    song.title
  end


# run! if __FILE__ == $0
end