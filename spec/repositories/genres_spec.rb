require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Genres do
	subject { Songify::Repositories::Genres.new }
	let(:genre) { Songify::Genre.new('fake_genre') }

	before do
    subject.drop_table
  end

	it "adds a new genre to the database" do
		expect(genre.id).to be_nil
		Songify.genres_repo.save_a_genre(genre)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to be(1)
	end

	it "gets all genres from the database" do
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to be(3)
	end

	it "selects a genre by its ID" do
		Songify.genres_repo.save_a_genre(genre)
		result = Songify.genres_repo.get_a_genre(1)
		expect(result.id).to eq(1)
		expect(result.class).to be(Songify::Genre)
	end

	it "deletes a genre by its ID" do
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.save_a_genre(genre)
		Songify.genres_repo.delete_a_genre(1)
		result = Songify.genres_repo.get_all_genres
		expect(result.first.id).to eq(2)
		expect(result.size).to eq(1)
	end

end