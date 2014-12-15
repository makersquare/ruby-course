require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require 'pry-byebug'

require_relative 'songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

album_repo = Songify::AlbumRepo.new
song_repo = Songify::SongRepo.new

get '/' do
  @albums = album_repo.get_all_albums
  erb :index
end

post '/' do 
  album_repo.add_new_album(params)
  redirect to('/')
end

get '/albums/:id' do
  album_id = params[:id]
  @album = album_repo.find_album({id: album_id}).first
  @songs = song_repo.find_songs({album_id: album_id})
  binding.pry
  erb :album
end

