require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'pry-byebug'

class Songify::Server < Sinatra::Application

  set :bind, '0.0.0.0'

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs
    @genres = Songify.genres_repo.get_all_genres
    erb :show
  end

  post '/create' do
    # in this case the user wants to select from dropdown
    if params["genre"].strip == ""
      genre = Songify.genres_repo.get_a_genre_by_name(params["genre-drop"])
      if genre.nil?
        genre = Songify::Genre.new(params["genre-drop"])
        Songify.genres_repo.save_a_genre(genre)
      end
    # user entered something in the text box
    else
      genre = Songify.genres_repo.get_a_genre_by_name(params["genre"].strip)
      if genre.nil?
        genre = Songify::Genre.new(params["genre"].strip)
        Songify.genres_repo.save_a_genre(genre)
      end
    end
    song = Songify::Song.new(params["title"], params["artist"], params["album"], genre.id)
    Songify.songs_repo.save_a_song(song)
    redirect '/'
  end

  get '/new' do
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  run! if __FILE__ == $0
end