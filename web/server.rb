require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'sinatra'

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

	get '/new' do
		erb :new
	end

	post '/create' do
		song = Songify::Song.new(params['title'], params['artist'], params['album'])
		genre = Songify::Genre.new(params['name'])
		Songify.songs_repo.save_a_song(song)
		Songify.genres_repo.save_a_genre(genre)
		song.title
		redirect to('/index')
	end

	run! if __FILE__ == $0
end

