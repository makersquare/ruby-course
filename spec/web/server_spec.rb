require 'server_spec_helper'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "Loads the homepage. Displays all songs in db" do
      Songify.songs.save_song(Songify::Song.new("Eleanor Rigby", "The Beatles", "The White Album"))
      get '/'
      expect(last_response.body).to include "Songify"
      Songify.songs.drop_and_rebuild_table
    end
  end
  
  describe "POST /" do
    it "Creates a new song. Adds to DB." do

    end
  end
end