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
  end

  describe "POST /create" do
    it "enters a new song in the database" do
      post '/create', { "title" => "post test title", "artist" => "post test artist", "album" => "post test album", "genre" => "genre1" }
      expect(last_response.status).to eq 302
    end
  end

  describe "/show" do
    it "shows all of the songs" do
      post '/create', { "title" => "title1", "artist" => "artist1", "album" => "album1", "genre" => "genre1" }
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "title1", "artist1", "album1", "genre1"
    end
  end

  describe "/new" do
    it "shows a form to get info about a new song" do
      get '/new'
      expect(last_response.body).to include "Artist:", "Album:", "Title:"
    end
  end

end