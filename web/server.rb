require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  set :bind, '0.0.0.0'

  get '/' do
    @songs = Songify.songs_repo.get_all_songs
    erb :index
  end

  get '/show/:id' do
    @song = Songify.songs_repo.get_a_song(params["id"])
    erb :show
  end

  post '/create' do
    @song = Songify::Song.new(params["title"], params["artist"], params["album"])
    Songify.songs_repo.save_a_song(@song)
    redirect '/'
  end

  get '/new' do
    erb :new
  end

  run! if __FILE__ == $0
end