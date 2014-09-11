require 'server_spec_helper'

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
      Songify.songs_repo.save_a_song(Songify::Song.new("fake_title", "fake_artist", "fake_album"))
      Songify.songs_repo.save_a_song(Songify::Song.new("fake_title_2", "fake_artist_2", "fake_album_2"))

      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "fake_title", "fake_title_2"
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
      post '/create', {title: "summers at lake kickapoo", artist: "the camps", album: "summer camp"}
      songs = Songify.songs_repo.get_all_songs
      expect(songs.last.title).to eq "summers at lake kickapoo"
    end
  end
end