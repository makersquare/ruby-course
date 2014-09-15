require 'server_spec_helper'

describe Songify::Server do 

  def app
    Songify::Server.new
  end

  describe "GET /" do 
    it "loads homepage" do 
      # Songify.songs_repo.save_song Songify::Song.new("fake_title", "fake_artist", "fake_album")
      # Songify.songs_repo.save_song Songify::Song.new("fake_title_two", "fake_artist_two", "fake_album_two")
      get '/'
      expect(last_response).to be_ok      
    end
  end

  describe "GET /show" do
    it "loads all songs" do
      Songify.songs_repo.save_song Songify::Song.new("fake_title", "fake_artist", "fake_album")
      Songify.songs_repo.save_song Songify::Song.new("fake_title_two", "fake_artist_two", "fake_album_two")
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "fake_title", "fake_title_two"
    end
  end

  describe "GET /new" do
    it "loads option to add new song" do
      get "/new"
      expect(last_response).to be_ok
    end
  end

  describe "POST /create" do
    it "post songs onto the create page" do
      post '/create', {"song_title" => "fake_title", "song_artist" => "fake_artist", "song_album" => "fake_album"}
      expect(last_response).to be_ok
      last_song = Songify.songs_repo.get_all_songs.last
      expect(last_response.body).to eq(last_song.title)
    end
  end
end