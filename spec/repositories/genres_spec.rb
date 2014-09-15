require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Genres  do
	let(:drop_genres) { Songify.genres_repo.drop_table}
	let(:genre) {genre = Songify::Genre.new('electro')}

	it "can save genre" do
		drop_genres
		expect(genre.id).to be_nil
		Songify.genres_repo.save_a_genre(genre)
		expect(genre.id).to_not be_nil
	end

	it "gets all genres from the table" do
		drop_genres
		genre2 = Songify::Genre.new('hip-hop')
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre2)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to eq(2)
	end

	it "gets a genre from the table by its id" do
		drop_genres
		Songify.genres_repo.save_a_genre(genre)
		result = Songify.genres_repo.get_a_genre(genre.id)
		expect(result).to be_a(Songify::Genre)
		expect(result.id).to eq(genre.id)
	end

	it "deletes a genre from the table" do 
		drop_genres
		genre2 = Songify::Genre.new('metal')
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre2)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to eq(2)

		Songify.genres_repo.delete_a_genre(genre2.id)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to eq(1)
	end
end