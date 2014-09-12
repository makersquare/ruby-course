require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs  do
	let(:drop) { Songify.genres_repo.drop_table}
	let(:genre) {genre = Songify::Genre.new('electro')}

	it "can save genre" do
		drop
		expect(genre.id).to be_nil
		Songify.genres_repo.save_a_genre(genre)
		expect(genre.id).to_not be_nil
	end

	it "gets all genres from the table" do
		drop
		genre2 = Songify::Genre.new('hip-hop')
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre2)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to eq(2)
	end

	it "gets a genre from the table by its id" do
		drop
		Songify.genres_repo.save_a_genre(genre)
		result = Songify.genres_repo.get_a_genre(genre.id)
		expect(result).to be_a(Songify::Genre)
		expect(result.id).to eq(genre.id)
	end

	# it "deletes a song from the table" do 
	# 	drop
	# 	song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
	# 	Songify.songs_repo.save_a_song(song)
	# 	Songify.songs_repo.save_a_song(song2)
	# 	result = Songify.songs_repo.get_all_songs
	# 	expect(result.size).to eq(2)

	# 	Songify.songs_repo.delete_a_song(song2.id)
	# 	result = Songify.songs_repo.get_all_songs
	# 	expect(result.size).to eq(1)
	# end
end