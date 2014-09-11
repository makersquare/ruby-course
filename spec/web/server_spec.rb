
require 'server_spec_helper'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "is the homepage" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "GET /show" do
    it "loads the song index" do
      get '/show'
      expect(last_response).to be_ok
    end
  end

  describe "GET /show_some" do
    it "loads a page where you can specify songs to retrieve" do
      get '/show_some'
      expect(last_response).to be_ok
    end
  end

  describe "POST /show_some" do
    it "displays the songs retrieved" do
      get '/show_some'
      expect(last_response).to be_ok
    end
  end

  describe "GET /new" do
    it "allows a song to be inputted" do
      get '/new'
      expect(last_response).to be_ok
    end
  end

  describe "POST /create" do
    it "saves the song" do
      post '/create', {'song_title' => "Radio Radio", 'song_artist' => "Elvis Costello", 'song_album' => "This Year's Model", 'song_yearpublished' => "1978", 'song_rating' => "5" }
      expect(last_response).to be_ok
    end
  end

  describe "GET /delete" do
    it "allows a song/all songs to be deleted" do
      get '/delete'
      expect(last_response).to be_ok
    end
  end

  describe "POST /delete" do
    it "displays a message about the destruction of the music database" do
      get '/delete'
      expect(last_response).to be_ok
    end
  end

end

