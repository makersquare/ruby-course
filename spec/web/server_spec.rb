require 'server_spec_helper'

require_relative './server_spec_helper.rb'



describe Songify::Server do 

  def app
    Songify::Server.new
  end


  describe "GET /index" do

    it "loads the index page" do

      get '/index'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Show", "new"
    end

  end

  describe "GET /show" do
    it "loads the show page which displays all song information" do
      song = Songify::Song.new("Dingus", "The Dingus", "Dingus")
      Songify.song_repo.save_song(song)
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Dingus", "The Dingus", "Dingus"


    end

  end

  describe "GET /new" do

    it "loads the new song form page" do
      get '/new'
      expect(last_response).to be_ok
       expect(last_response.body).to include "Song Title:", "Artist:", "Album:" 
    end


  end

  describe "POST /create" do
    it 'puts the new song into the database' do
      size = Songify.song_repo.get_all_songs.size
      post '/create', {"title" => "Dingus", "artist" => "The Dingus", "album" => "Dingus"}

      expect(last_response.status).to eq(302)
      expect(Songify.song_repo.get_all_songs.size).to eq (size+1)
      
    end

  end




end