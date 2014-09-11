require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'
  get '/' do 
    erb :index
  end
  # run!

  get '/show' do 
    @songs = Songify.songs_repo.get_all_songs
    erb :show
  end

  get '/new' do 
    song = Songify::Song.new(params["title"],params["artist"],params["album"])
    Songify.songs_repo(song)
    erb :new
  end

  # post '/create' do 
  #   erb :create
  # end
  run! if __FILE__ == $0
end

