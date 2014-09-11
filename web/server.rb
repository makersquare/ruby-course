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
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  post '/create' do
    @genres = Songify.genres_repo.get_all_genres
    if [params["title"], params["artist"], params["album"]].any? {|x| x == ""}
      erb :error
    elsif params["genre_id"] && params["genre_id"] != ""
      song = Songify::Song.new(params["title"], params["artist"], params["album"])
      genre = Songify.genres_repo.get_genre(params["genre_id"].to_i)
      Songify.songs_repo.save_song(song, genre)
      erb :create
    elsif params["genre"] != ""
      match = @genres.find {|x| x.genre_name == params["genre"].downcase}
      if match
        song = Songify::Song.new(params["title"], params["artist"], params["album"])
        Songify.songs_repo.save_song(song, match)
      else
        new_genre = Songify::Genre.new(params["genre"])
        Songify.genres_repo.save_genre(new_genre)
        song = Songify::Song.new(params["title"], params["artist"], params["album"])
        Songify.songs_repo.save_song(song, new_genre)
      end
      erb :create
    else
      erb :error
    end
  end

  run! if __FILE__ == $0
end

