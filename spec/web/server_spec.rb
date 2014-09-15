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
    pop = Songify::Genre.new("pop") 
    Songify.genres_repo.save_genre(pop)
    song1 = Songify::Song.new("fake_title", "fake_artist", "fake_album")
    song2 = Songify::Song.new("2fake_title", "2fake_artist", "2fake_album")
    song1.set_genre_id(pop)
    song2.set_genre_id(pop)
    Songify.songs_repo.save_song(song1)
    Songify.songs_repo.save_song(song2)
    get "/show"

    pop_id = pop.id

    expect(last_response).to be_ok
    expect(last_response.body).to include "2fake_title"
    expect(last_response.body).to include (pop_id.to_s)

  end
end

  describe "GET /new" do
  it "provides fields to enter song title, artist, genre and album into the database" do
    get "/new"
    

    expect(last_response).to be_ok
  end
end

describe "POST /create" do
  it "saves songs to the database" do
    post "/create", {"title" => "Song I entered", "artist" => "Artist I entered", "album" => "album I entered", "add_genre_name" => "mumblecore"}
    
    last_song = Songify.songs_repo.get_all_songs 
    added_genre = Songify.genres_repo.get_all_genres.last
    
    expect(last_song.last.title).to eq "Song I entered"
    expect(last_song.last.genre_id).to_not be_nil
    
    expect(added_genre.name).to eq("mumblecore")
    
    expect(last_response.location).to include "/show"

    
  end
end

describe "GET /show_genres" do
  it "shows all genres in the database" do

  pop = Songify::Genre.new("pop")
  Songify.genres_repo.save_genre Songify::Genre.new("smooth jazz")
  Songify.genres_repo.save_genre(pop) 
        get "/show_genres"

  expect(last_response.body).to include ("smooth jazz")
    expect(last_response.body).to include ("pop")

  end
end


describe "POST /genre" do
  it "requests all songs of a certain genre from the database" do
    mumblecore = Songify::Genre.new("mumblecore")
    Songify.genres_repo.save_genre(mumblecore)
    tune1 = Songify::Song.new("tune_title", "tune_artist", "tune_album")
    tune1.set_genre_id(mumblecore)
    Songify.songs_repo.save_song(tune1)

    post "/genre", {"genres" => "mumblecore"}

    expect(last_response.body).to include ("tune_title")
  end
end


describe "GET /this_genre" do
  it "shows songs of a selected genre" do
    mumblecore = Songify::Genre.new("mumblecore")
    Songify.genres_repo.save_genre(mumblecore)
    tune1 = Songify::Song.new("tune_title", "tune_artist", "tune_album")
    tune1.set_genre_id(mumblecore)
    Songify.songs_repo.save_song(tune1)

    get "/this_genre", {"genres" => "mumblecore"}

  expect(last_response.body).to include ("tune_title")

end
end





end

  