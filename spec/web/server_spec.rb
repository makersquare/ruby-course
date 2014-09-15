require 'server_spec_helper'
require 'pry-byebug'
describe Songify::Server do
	
	def app
		Songify::Server.new
	end
	
	describe 'GET /index' do
		it "shows all the songs" do
			Songify.songs_repo.drop_table
			genre = Songify::Genre.new('electro')
			Songify.genres_repo.save_a_genre(genre)
			song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
			song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
			Songify.songs_repo.save_a_song(song, genre)
			Songify.songs_repo.save_a_song(song2, genre)
			get '/index'
			expect(last_response).to be_ok
			expect(last_response.body).to include "fake_title", "fake_title2"
		end
	end

	describe 'GET /show/:id' do
		it "shows the song being requested" do
			Songify.songs_repo.drop_table
			genre = Songify::Genre.new('electro')
			Songify.genres_repo.save_a_genre(genre)
			song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
			song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
			Songify.songs_repo.save_a_song(song, genre)
			Songify.songs_repo.save_a_song(song2, genre)
			get "/show/id"
			expect(last_response.body).to include "fake_title"
		end
	end

	describe 'get /new' do
		it "shows a form and takes input" do
			Songify.songs_repo.drop_table
			get '/new'
			expect(last_response).to be_ok
			expect(last_response.body).to include 'submit'
		end
	end

	describe 'post /create' do
		it "creates a song and puts into the table" do
			Songify.songs_repo.drop_table
			Songify.genres_repo.drop_table
			post '/create', {'title'=>'fake_title', 'artist'=>'fake_artist', 'album'=>'fake_album', 'genre' => 'fake_genre'}
			expect(last_response.status).to eq(302)
			result = Songify.songs_repo.get_all_songs
			expect(result.last.title).to eq('fake_title')
		end
	end
end