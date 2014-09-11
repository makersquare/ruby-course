require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do

  def app
    Songify::Server.new
  end 

  describe "GET /" do
    it "loads the homepage" do
      get '/'
      expect(last_response).to be_ok
    end 
  end

  describe 'GET /show' do
    it "shows all the songs" do
      Songify.songs_repo.save_a_song  Songify::Song.new("First Song", "Fake Artist", "Fake Album")
      Songify.songs_repo.save_a_song  Songify::Song.new("Second Song", "Fake Artist 2", "Fake Album 2")
      get '/show'
      expect(last_response.body).to include "First Song, Fake Artist, Fake Album", "Second Song Fake Artist 2, Fake Album 2"
    end 
  end

  describe "GET /new" do
    it "loads the homepage" do
      get '/new'
      expect(last_response.status).to be_ok
    end
  end

  describe "POST /create" do
    it "creates a song" do
      post '/create', {"title" => "Fake Title", "artist" => "Fake Artist", "album" => "Fake Album"}
      expect(last_response.status).to eq(302)
      expect(Songify.songs_repo.get_all_songs.length).to eq(1)
    end
  end
end