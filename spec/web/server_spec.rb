require 'server_spec_helper'
require 'pry-byebug'
describe Songify::Server do
	
	def app
		Songify::Server.new
	end
	
	describe 'GET /index' do
		it "shows all the songs" do
			# Songify.songs_repo.drop_table
			song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
			song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
			Songify.songs_repo.save_a_song(song)
			Songify.songs_repo.save_a_song(song2)
			get '/index'
			expect(last_response).to be_ok
			expect(last_response.body).to include "fake_title", "fake_title2"
		end
	end

	describe 'GET /show/:id' do
		it "shows the song being requested" do
			# Songify.songs_repo.drop_table
			song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
			song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
			Songify.songs_repo.save_a_song(song)
			Songify.songs_repo.save_a_song(song2)
			get "/show/id"
			expect(last_response).to be_ok
			expect(last_response.body).to include "fake_title"
		end
	end

	describe 'get /new' do
		it "shows a form and takes input" do
			# Songify.songs_repo.drop_table
			get '/new'
			expect(last_response).to be_ok
			expect(last_response.body).to include 'submit'
		end
	end

	describe 'post /create' do
		it "creates a song and puts into the table" do
			# Songify.songs_repo.drop_table
			# Songify.genres_repo.drop_table
			post '/create', {'title'=>'fake_title', 'artist'=>'fake_artist', 'album'=>'fake_album', 'genre' => 'fake_genre'}
			expect(last_response.status).to eq(302)
			result = Songify.songs_repo.get_all_songs
			result = Songify.genres_repo.get_all_genres
			expect(result.last.title).to eq('fake_title')
			expect(result.last.name).to eq('fake_genre')
		end
	end

	describe 'get/new_genre' do
		it "shows a form and takes input" do
			# Songify.genres_repo.drop_table
			get '/new_genre'
			expect(last_response).to be_ok
			expect(last_response.body).to include form
		end
	end
end