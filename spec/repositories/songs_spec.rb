require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs  do
	let(:drop) { Songify.songs_repo.drop_table}
	let(:song) {song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')}

	it "can save song" do
		drop
		genre = Songify::Genre.new('electro')
		Songify.genres_repo.save_a_genre(genre)
		expect(song.id).to be_nil
		Songify.songs_repo.save_a_song(song, genre)
		expect(song.id).to_not be_nil
	end

	it "gets all songs from the table" do
		drop
		genre = Songify::Genre.new('electro')
		Songify.genres_repo.save_a_genre(genre)
		song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
		Songify.songs_repo.save_a_song(song, genre)
		Songify.songs_repo.save_a_song(song2, genre)
		result = Songify.songs_repo.get_all_songs
		expect(result.size).to eq(2)

	end

	it "gets a song from the table by its id" do
		drop
		song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
		genre = Songify::Genre.new('electro')
		Songify.genres_repo.save_a_genre(genre)
		Songify.songs_repo.save_a_song(song, genre)
		result = Songify.songs_repo.get_a_song(song.id)
		expect(result).to be_a(Songify::Song)
		expect(result.id).to eq(song.id)
	end

	it "deletes a song from the table" do 
		drop
		song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
		genre = Songify::Genre.new('electro')
		Songify.genres_repo.save_a_genre(genre)
		Songify.songs_repo.save_a_song(song, genre)
		Songify.songs_repo.save_a_song(song2, genre)
		result = Songify.songs_repo.get_all_songs
		expect(result.size).to eq(2)

		Songify.songs_repo.delete_a_song(song2.id)
		result = Songify.songs_repo.get_all_songs
		expect(result.size).to eq(1)
	end
end