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

get '/albums/:album_id/songs/:id' do
  album_id = params[:album_id]
  song_id = params[:id]
  @album = album_repo.find_album({id: album_id}).first
  @songs = song_repo.find_songs({album_id: album_id})
  @song = song_repo.find_songs({id: song_id}).first
  erb :album, :layout => :layout do
    erb :song
  end
end

put '/albums/:album_id/songs/:id' do
  new_album = album_repo.find_album({title: params[:album]}).first
  song_repo.update_song({
    id: params[:id],
    name: params[:name],
    album_id: new_album.id,
    embed: params[:embed]
  })
  redirect back
end

delete '/albums/:album_id/songs/:id' do 
  @song = song_repo.delete_song({id: params[:id]})
  redirect back
end

get '/albums/:id' do
  album_id = params[:id]
  @album = album_repo.find_album({id: album_id}).first
  @songs = song_repo.find_songs({album_id: album_id})
  erb :album, :layout => :layout
end

delete '/albums/:id' do 
  @album = album_repo.delete_album({id: params[:id]})
  redirect('/')
end 

put '/albums/:id' do   
  @album = album_repo.update_album(
    {id: params[:id],
      title: params[:title],
      artist: params[:artist],
      cover: params[:cover]
      })
  redirect to('/')
end

