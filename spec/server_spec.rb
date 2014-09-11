#write for index show new create
require 'pry-byebug'
require 'server_spec_helper'

describe Songify::Server do 
  def app
    Songify::Server.new
  end

  describe 'GET /' do 
    it 'loads the homepage' do
      
      get '/'
      expect(last_response).to be_ok
      
    end
  end
  describe 'GET /show' do 
    it 'prints out the songs in the database' do 
      song = Songify::Song.new("Booty Pop", "Hootie hoo", "Booty songs")
      Songify.songs_repo.save_a_song(song)
      get '/show'

      expect(last_response.body).to include 'Booty Pop'
    end
  end

  describe 'GET /new' do 
    it 'displays a page where the user can enter a song in the database' do
      get '/new'
      # binding.pry
      expect(last_response).to be_ok
      expect(last_response.body).to include "Title"
    end
  end

  describe 'POST /create' do 
    it 'puts user input into the database' do 
      post '/create', {"title" => "girls", "artist"=>"beastie boys", "album"=>"stuff"}
      #somehow get the variable
      last_song = Songify.songs_repo.get_all_songs.last
      get '/show'
      expect(last_response.body).to include(last_song.title)
    end
  end
end