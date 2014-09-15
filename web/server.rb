require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'sinatra'
require 'pry-byebug'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get '/' do
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
    song = Songify::Song.new(params["title"], params["artist"], params["album"])
    @all_genres = Songify.genres_repo.get_all_genres
    binding.pry
    if @all_genres.include? (params["genre"])
      input = (params["genre"])
      Songify.songs_repo.save_a_song(song, input)
    else
      input = Songify::Genre.new(params["genre"])
      genre = Songify.genres_repo.save_genre(input)
      Songify.songs_repo.save_a_song(song, genre)
    end
    

    redirect to '/show'
  end


end