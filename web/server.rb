require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  set :bind, '0.0.0.0'

  get '/index' do
    erb :index
  end

  post '/index' do
    if params["action"] == "get_all"
      redirect '/show'
    elsif params["action"] == "post"
      redirect '/create'
    elsif params["action"] == "delete"
    end
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs
    erb :show
  end

  get '/create' do
    erb :create
  end

  post '/new' do
    @song = Songify::Song.new(params["title"], params["artist"], params["album"])
    Songify.songs_repo.save_a_song(@song)
    erb :new
  end

  run! if __FILE__ == $0
end