require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "loads the page successfully" do
      get '/'
      expect(last_response).to be_ok
    end

    it "displays a list of all of the songs in database" do
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 1", "test artist 1", "test album 1"))
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 2", "test artist 2", "test album 2"))
      Songify.songs_repo.save_a_song(Songify::Song.new("test title 3", "test artist 3", "test album 3"))

      get '/'

      expect(last_response.body).to include "test title 1", "test artist 1", "test album 1",
                                            "test title 2", "test artist 2", "test album 2",
                                            "test title 3", "test artist 3", "test album 3"
    end
  end

  describe "POST /create" do
    it "enters a new song in the database" do
      post '/create', { "title" => "post test title", "artist" => "post test artist", "album" => "post test album" }
      expect(last_response.status).to eq 302
    end
  end

  describe "/show/:id" do
    it "shows a single song based on a given id in the url" do
      Songify.songs_repo.drop_table
      Songify.songs_repo.save_a_song(Songify::Song.new("yusef", "yusef", "yusef"))
      get '/show/1'
      expect(last_response).to be_ok
      expect(last_response.body).to include "yusef"
    end
  end

  describe "/new" do
    it "shows a form to get info about a new song" do
      get '/new'
      expect(last_response.body).to include "Artist:", "Album:", "Title:"
    end
  end

end