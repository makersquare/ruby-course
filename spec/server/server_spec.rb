require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do
  def app
    Songify::Server.new
  end

  describe "Get /" do
    it "Will load the default page." do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "Show all Songs." do
    it "Will Show all songs currently loaded." do
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "artist10" 
    end
  end

  describe "New Song Page." do
    it "Allows you to fill out a form to create a song." do
      get '/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Album" 
    end
  end

  describe "Create Song Functionality" do
    it "Allows values filled into New Song to create a new song." do
      post '/create', {"length"=>"5","artist"=>"Servercheck","title"=>"Servercheck","album"=>"Servercheck"}     
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Servercheck" 
    end
  end
end