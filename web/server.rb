require_relative "../lib/songify.rb"
require 'sinatra/base'
require "sinatra"

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application
Songify.songs_repo = Songify::Repo::Songs.new("songify_dev")

  get "/" do 
    erb :index
  end

  get "/show" do 
    @songs = Songify.songs_repo.get_all_songs
    erb :show 
  end

  get "/new" do #form to get song and sends it to create
    erb :new
  end

  post "/create" do
    song = Songify::Song.new(params["title"], params["artist"], params["genre"])

    Songify.songs_repo.save_song(song)
        redirect to('/show')

  end

  # get "/create" do
  # end
 
run! if __FILE__ == $0
  end

##Questions: should songs be showing up?
##Why won't it redirect