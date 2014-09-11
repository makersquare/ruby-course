require 'server_spec_helper'

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

  describe "GET /show" do
    it "displays all songs in database in its own page"  do
      song1 = Songify::Song.new("song_title1", "Artist Name", "Album Title")
      song2 = Songify::Song.new("song_title2", "Some Artist", "Horrible Album")
      Songify.songs_repo.save_a_song(song1)
      Songify.songs_repo.save_a_song(song2)
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "song_title1", "song_title2"
    end
  end

  describe "GET /new" do
    it "loads the Create page to create a new song" do
      get '/new'
      expect(last_response).to be_ok
    end
  end

  describe "POST /create" do
    it "creates a new song to add to database" do
      post '/create', { "title" => "song_title3", "artist" => "some_artist", "album" => "some_album" }
      expect(last_response).to be_ok

      last_song = Songify.songs_repo.get_all_songs.last
      expect(last_response.body).to eq(last_song.title)
    end
  end

end