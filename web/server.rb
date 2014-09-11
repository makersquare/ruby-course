require_relative '../lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index, :locals => {
      songs: Songify.songs.get_all_songs
    }
  end

  post '/' do
    # genre = Songify::Genre.new(params["genre"])
    # genre_id = genre.id
    song = Songify::Song.new(params["title"], params["artist"], params["album"], params["year"], params["genre"], params["rating"])
    Songify.songs.save_song(song)
    erb :index, :locals => {
      songs: Songify.songs.get_all_songs
    }
  end


  run! if __FILE__ == $0
end