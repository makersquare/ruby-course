require "server_spec_helper"

describe Songify::Server do
  
  def app
    Songify::Server.new
  end


describe "GET /" do
    it "loads the homepage" do
      get '/'

      expect(last_response).to be_ok
    end
    it "contains links to show all songs, save new song, and create song" do

      get '/'
    expect(last_response.body).to include "Show all songs", "New song" 
  end
end

describe "GET /show" do
  it "shows all songs in the database" do
    Songify.songs_repo.save_song Songify::Song.new("fake_title", "fake_artist", "fake_genre")
    Songify.songs_repo.save_song Songify::Song.new("2fake_title", "2fake_artist", "2fake_genre")

    get "/show"

    expect(last_response).to be_ok
    expect(last_response.body).to include "2fake_title"
  end
end

  describe "GET /new" do
  it "provides fields to enter song title, artist and genre into the database" do
    get "/new"
    

    expect(last_response).to be_ok
  end
end

describe "POST /create" do
  it "saves songs to the database" do
    post "/create", {"title" => "Song I entered", "artist" => "Artist I entered", "genre" => "Genre I entered"}
    
    last_song = Songify.songs_repo.get_all_songs.last

    expect(last_song.title).to include "Song I entered"
  end
end

end

  