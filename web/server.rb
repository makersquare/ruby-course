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
    genre_id = nil
    genre_name = params["genre"]
    if params["other-genre"]!=''
      genre_name = params["other-genre"]
    end
    genre_match = Songify.genres.get_all_genres.find { |x| x.name == genre_name }
    if genre_match == nil
      genre = Songify::Genre.new(genre_name)
      Songify.genres.add_genre(genre)
      genre_id = Songify.genres.get_all_genres.last.id
    else
      genre_id = genre_match.id
    end
    song = Songify::Song.new(params["title"], params["artist"], params["album"], params["year"], genre_id, params["rating"])

    Songify.songs.save_song(song)
    erb :index, :locals => {
      songs: Songify.songs.get_all_songs,
      genres: Songify.genres.get_all_genres
    }
  end


  run! if __FILE__ == $0
end