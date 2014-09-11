require 'server_spec_helper'

require_relative './server_spec_helper.rb'



describe Songify::Server do 

  def app
    Songify::Server.new
  end


  describe "GET /index" do

    it "loads the index page" do

      get '/index'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Show", "new"
    end

  end

  describe "GET /show" do
    it "loads the show page which displays all song information" do
      song = Songify::Song.new("Dingus", "The Dingus", "Dingus")
      Songify.song_repo.save_song(song)
      get '/show'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Dingus", "The Dingus", "Dingus"


    end

  end

  describe "GET /new" do

    it "loads the new song form page" do

      get '/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Song Title:", "Artist:", "Album:" 
    end

    it "properly loads the genre select menu" do

      genre1 = Songify::Genre.new("Pop")
      genre2 = Songify::Genre.new("Techno")
      genre3 = Songify::Genre.new("Rap")
      Songify.genre_repo.save_genre(genre1)
      Songify.genre_repo.save_genre(genre2)
      Songify.genre_repo.save_genre(genre3)

      get '/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Pop", "Techno", "Rap"

    end


  end

  describe "POST /create" do
    it 'puts the new song into the database' do
      size = Songify.song_repo.get_all_songs.size
      post '/create', {"title" => "Dingus", "artist" => "The Dingus", "album" => "Dingus"}

      expect(last_response.status).to eq(302)
      expect(Songify.song_repo.get_all_songs.size).to eq (size+1)
      
    end

    it 'puts the genre into the database if it is new' do
        size = Songify.genre_repo.get_all_genres.size
        post '/create', {"title" => "Dingus", "artist" => "The Dingus", "album" => "Dingus", "chosen_genre" => "select a genre", "new_genre" => "Super Dingus Genre" }

        expect(last_response.status).to eq(302)
        expect(Songify.genre_repo.get_all_genres.size).to eq (size+1)
    end

    it 'does not add the genre to the database if it is already present' do 
        pop = Songify::Genre.new("Pop")
        Songify.genre_repo.save_genre(pop)
        size = Songify.genre_repo.get_all_genres.size
        post '/create', {"title" => "Dingus", "artist" => "The Dingus", "album" => "Dingus", "chosen_genre" => "Pop"}

        expect(last_response.status).to eq(302)
        expect(Songify.genre_repo.get_all_genres.size).to eq (size)
    end

  end




end