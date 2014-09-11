require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'pry-byebug'

class Songify::Server < Sinatra::Application

  set :bind, "0.0.0.0"

  get '/index' do
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
    if [params["title"], params["artist"], params["album"], params["genre"]].any? {|x| x == nil}
      erb :error
    else
      song = Songify::Song.new(params["title"], params["artist"], params["album"], params["genre"])
      Songify.songs_repo.save_song(song)
      erb :create
    end
  end

  run! if __FILE__ == $0
end

# <% song = Songify.songs_repo.get_song(song_id) %>
#   <%= song.title %>
#   <%= song.artist %>
#   <%= song.album %>
#   <%= song.genre %>
#   <%= song.length %>

