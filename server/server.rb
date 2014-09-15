require_relative '../lib/songify.rb'
require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'
class Songify::Server < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/show' do
    all = Songify.song_repo.get_all_songs
    genres = Songify.genre_repo.get_all_genres
    erb :show, :locals=>{:all=> all, :genres=>genres}
  end

  get '/showgenre' do
    id = params["genre_id"].to_i
    all = Songify.song_repo.get_a_genre(1)
    binding pry-byebug
    erb :showgenre, :locals=>{:all=> all}
  end

  get '/new' do
    genres = Songify.genre_repo.get_all_genres
    erb :new, :locals=>{:genres=> genres}
  end

  post '/create' do
    song = Songify::Song.new(params["artist"],params["title"],params["album"],params["length"],params["genre_id"])
    Songify.song_repo.save_a_song(song)
    redirect to '/show'
  end

  post '/creategenre' do
    genre = Songify::Genre.new(params["type"])
    Songify.genre_repo.save_genre(genre)
    redirect to '/show'
  end

  run! if __FILE__ == $0
end