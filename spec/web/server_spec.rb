require 'server_spec_helper'

describe Songify::Server do
  
  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "loads the homepage" do
      get '/index'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Songify"
    end

    it "loads the show songs page" do
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Show Songs"
    end

    it "loads the add new song page" do
      get '/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Add New Song"
    end
  end

  describe "POST /" do
    it "loads the song created page" do
      post '/create', {"title" => "Song Title", "artist" => "Song Artist", "album" => "Song Album", "genre" => "Song Genre", "length" => "Song Length"}
      expect(last_response).to be_ok
      expect(last_response.body).to include "add"
    end
  end

end