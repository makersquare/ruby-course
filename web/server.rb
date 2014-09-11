require_relative '../lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index, :locals => {
      songs: Songify.songs.get_all_songs,
      genres: Songify.genres.get_all_genres
    }
  end

  post '/' do
    genre = Songify::Genre.new(params["genre"]) # Pulling genre from text entry.
    Songify.genres.add_genre(genre) # Adding genre to genres repo.
    genre_list = Songify.genres.get_all_genres # Pulling a genre list from genres table.
    genre_id = genre_list.last.id # Pulling newest genre id.
    
    song = Songify::Song.new(params["title"], params["artist"], params["album"], params["year"], genre_id, params["rating"])
    Songify.songs.save_song(song)
    erb :index, :locals => {
      songs: Songify.songs.get_all_songs,
      genres: Songify.genres.get_all_genres
    }
  end


  run! if __FILE__ == $0
end