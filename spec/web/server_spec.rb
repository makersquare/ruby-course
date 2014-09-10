require 'server_spec_helper'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /show" do
    it "loads the page successfully" do
      get '/show'
      expect(last_response).to be_ok
    end

    it "displays a list of all of the songs in database" do
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 1", "test artist 1", "test album 1"))
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 2", "test artist 2", "test album 2"))
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 3", "test artist 3", "test album 3"))

      get '/show'

      expect(last_response.body).to include "test title 1", "test artist 1", "test album 1",
                                            "test title 2", "test artist 2", "test album 2",
                                            "test title 3", "test artist 3", "test album 3"
    end
  end

  describe "POST /create" do
    it "enters a new song in the database" do
      post '/create', { "title" => "post test title", "artist" => "post test artist", "album" => "post test album" }
      expect(last_response).to be_ok
      expect(last_response.body).to include "post test title", "post test artist", "post test album"
    end
  end

  describe ""

end