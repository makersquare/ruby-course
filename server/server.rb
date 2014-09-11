require_relative '../lib/songify.rb'
require 'sinatra'
require 'sinatra/reloader'

class Songify::Server < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/show' do
    all = Songify.song_repo.get_all_songs
    erb :show, :locals=>{:all=> all}
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    song = Songify::Song.new(params["artist"],params["title"],params["album"],params["length"])
    Songify.song_repo.save_a_song(song)
    redirect to '/show'
  end

  run! if __FILE__ == $0
end