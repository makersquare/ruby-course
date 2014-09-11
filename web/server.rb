require_relative '../lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/base'

class Songify::Server < Sinatra::Application

 get '/index' do
    erb :index
 end

 get '/show' do
    songs = Songify.song_repo.get_all_songs
    erb :show, :locals => {songs: songs}
 end

 get '/new' do 
    genres = Songify.genre_repo.get_all_genres
    erb :new, :locals => {genres: genres}
 end

 post '/create' do

    title = params["title"]
    artist = params["artist"]
    album = params["album"]
    chosen_genre = params["chosen_genre"]

    if chosen_genre == "select a genre"
        genre = params["new_genre"]
    else
        genre = chosen_genre
    end

    known_genre_titles = Songify.genre_repo.get_all_genres.map {|x| x.title}

    if (!known_genre_titles.include?(genre))
        genre = Songify::Genre.new(genre)
        Songify.genre_repo.save_genre(genre)
    end

    song = Songify::Song.new(title, artist, album)
    Songify.song_repo.save_song(song)
    redirect to('/index')

 end

 run! if __FILE__ == $0



end

