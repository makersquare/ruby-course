require 'server_spec_helper'

describe Songify::Server do
  
  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "loads the homepage" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "GET /show" do
    it "displays all songs in database in its own page"  do
      song1 = Songify::Song.new("song_title1", "Artist Name", "Album Title", 1)
      song2 = Songify::Song.new("song_title2", "Some Artist", "Horrible Album", 1)
      Songify.songs_repo.save_a_song(song1)
      Songify.songs_repo.save_a_song(song2)
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "song_title1", "song_title2"
    end
  end

  describe "GET /new" do
    it "loads the Create page to create a new song" do
      get '/new'
      expect(last_response).to be_ok
    end
  end

  describe "POST /create" do
    it "creates a new song to add to database" do
      genre = Songify::Genre.new("fake_genre")
      genre1 = Songify::Genre.new('fake_genre1')
      Songify.genres_repo.save_a_genre(genre.name)
      Songify.genres_repo.save_a_genre(genre1.name)
      post '/create', { "title" => "song_title3", "artist" => "some_artist", "album" => "some_album", "genre" => "fake_genre"}
      expect(last_response.redirect?).to be_true
      follow_redirect!
      allGenres = Songify.genres_repo.get_all_genres
      expect(allGenres.size).to be(2)
      last_song = Songify.songs_repo.get_all_songs.last
      expect(last_song.genre_id).to eq(1)
      expect(last_response.body).to include(last_song.title)
    end

    it "creates a new song when the given genre does not yet exist" do
      post '/create', {"title" => "song_title4", "artist" => "some_other_artist", "album" => "another_album", "genre" => "mindless screaming"}
      result = Songify.genres_repo.has_genre?('mindless screaming')
      expect(result).to be(false)
      expect(last_response.redirect?).to be_true
      follow_redirect!
      last_song1 = Songify.songs_repo.get_all_songs.last
      expect(last_song1.genre_id).to eq(1)
      expect(last_response.body).to include(last_song1.title)
    end
  end

  Songify.songs_repo.drop_table
  Songify.genres_repo.drop_table

  Songify.songs_repo =Songify::Repositories::Songs.new
  Songify.genres_repo = Songify::Repositories::Genres.new
end