require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?

require_relative 'songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

album_repo = Songify::AlbumRepo.new

get '/' do
  @albums = album_repo.get_all_albums
  erb :index
end

post '/' do 
  album_repo.add_new_album(params)
  redirect to('/')
end

