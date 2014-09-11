require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "loads the homepage" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Songify"
    end

    it "shows all songs" do
      genre1 = Songify::Genre.new("rock")
      song1 = Songify::Song.new("rock_title", "rock_artist", "rock_album")
      song2 = Songify::Song.new("rock_title_2", "rock_artist_2", "rock_album_2")

      Songify.genres_repo.save_genre(genre1)


      Songify.songs_repo.save_a_song(song1, genre1)
      Songify.songs_repo.save_a_song(song2, genre1)

      # song_list = Songify.songs_repo.get_all_songs
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include("rock_title", "rock_title_2")
    end

    it "gets a new song form" do
      get '/new' do
      expect(last_response).to be_ok
      expect(last_response.body).to include "form"
      end
    end
  end

  describe "POST /" do
    it "creates song and adds it to /show" do
      post '/create', {"title" => "rock_title", "artist" => "rock_artist", "album" => "rock_album", "genre_id" => "id"}
      expect(last_response.status).to eq 302
      song = Songify.songs_repo.get_all_songs
      # binding.pry
      expect(song.first.title).to eq "rock_title"
      expect(song.first.genre_id).to_not be_nil
    end
  end
end