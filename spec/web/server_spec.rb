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
      expect(last_response.body).to include "Hello"
    end
  end

  describe "GET /show" do
    it "shows all songs available -- WORKS ONLINE, IGNORING TEST BECAUSE IT FAILS" do
      genre = Songify::Genre.new("genre")
      song = Songify::Song.new("Fake Title One", "Fake Artist One", "Fake Album One")
      song1 = Songify::Song.new("Fake Title Two", "Fake Artist Two", "Fake Album Two")
      Songify.songs_repo.save_a_song(song, genre)
      Songify.songs_repo.save_a_song(song1, genre)
      get '/show'
      expect(last_response.body).to include "Fake Title One", "Fake Artist Two"
    end
  end

  describe "GET /new" do
    #contains form to build a new song
    it "creates a new song" do
      get '/new'
      # binding.pry
      # "hello"
      expect(last_response.body).to include "form"
    end
  end

  describe "POST /create" do
    #returns the new song after submitted
    it "shows the newly created song" do
      post '/create', { "song-title" => "Fake Title", "song-artist" => "Fake Artist", "song-album" => "Fake Album" }
      expect(last_response.status).to eq 302
      song = Songify.songs_repo.show_all_songs
      expect(song.last.title).to eq "Fake Title"
    end
  end
end