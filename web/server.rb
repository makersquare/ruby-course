require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'sinatra'
require 'pry-byebug'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

	get '/index' do
		songs_array = Songify.songs_repo.get_all_songs
		erb :index, :locals => {songs: songs_array}
	end

	get '/show/:id' do
		song = Songify.songs_repo.get_a_song(params[:id].to_i)

		erb :show, :locals => {song: song}
	end

	get '/genre_select' do
		genres_array = Songify.genres_repo.get_all_genres

		erb :genre_select, :locals => {genres: genres_array}
	end

	post '/genre_select' do
		songs_array = Songify.songs_repo.get_songs_by_genre(params['select_genre'])
		genres_array = Songify.genres_repo.get_all_genres

		erb :genre_select, :locals => {songs: songs_array, genres: genres_array}
	end

	get '/new' do
		genres_array = Songify.genres_repo.get_all_genres
		erb :new, :locals => {genres: genres_array}
	end

	post '/create' do
		song = Songify::Song.new(params['title'], params['artist'], params['album'])
		if params['genre'] == ""
			genre = Songify.genres_repo.get_a_genre(params['select_genre'].to_i)
			Songify.songs_repo.save_a_song(song, genre)
		else
			genre = Songify::Genre.new(params['genre'])
			Songify.genres_repo.save_a_genre(genre)
			Songify.songs_repo.save_a_song(song, genre)
		end
		song.title
		redirect to('/index')
	end

	run! if __FILE__ == $0
end

