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
    erb :new
 end

 post '/create' do
    title = params["title"]
    artist = params["artist"]
    album = params["album"]
    song = Songify::Song.new(title, artist, album)
    Songify.song_repo.save_song(song)
    redirect to('/index')
 end

 run! if __FILE__ == $0



end

