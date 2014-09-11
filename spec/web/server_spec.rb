require 'server_spec_helper'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    # it "Loads the homepage. Displays all songs in db" do
    #   Songify.songs.save_song(Songify::Song.new("Eleanor Rigby", "The Beatles", "The White Album", 1968, "Classic Rock", 5))
    #   get '/'
    #   expect(last_response.body).to include "Eleanor", "Beatles", "White", "1968", "Classic", "5"
    # end
  end
  
  describe "POST /" do
    # it "Creates a new song. Adds to DB." do
    #   post '/', { 'title' => "Radio Radio", 'artist' => "Elvis Costello", 'album' => "This Year's Model", 'year' => 1978, 'genre' => "Punk Rock", 'rating' => 4}
    #   last_song = Songify.songs.get_all_songs.last
    #   expect(last_response.body).to include "Radio", "Elvis", "Year's", "1978"
    #   # Songify.songs.drop_and_rebuild_table
    # end
  end
end