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
    song_genres = []
    songs.each do |x|
        genre = Songify.genre_repo.get_genre(x.genre_id)
        song_genres.push(genre)
    end
    erb :show, :locals => {songs: songs, song_genres: song_genres}
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

    if (known_genre_titles.include?(genre) == false)
        new_genre = Songify::Genre.new(genre)
        Songify.genre_repo.save_genre(new_genre)
        all_genres = Songify.genre_repo.get_all_genres
        new_genre = all_genres.find {|x| x.title == genre}
        genre_id = new_genre.id
    else
        all_genres = Songify.genre_repo.get_all_genres
        new_genre = all_genres.find {|x| x.title == genre}
        genre_id = new_genre.id
    end

    song = Songify::Song.new(title, artist, album)
    puts "genre id is: " + "#{genre_id}"
    #adjust song repo table to have genre_id
    song.instance_variable_set(:@genre_id, genre_id)
    puts "song.genre_id is : " + "#{song.genre_id}; saving to db"
    Songify.song_repo.save_song(song)

    redirect to('/index')

 end

 run! if __FILE__ == $0



end

