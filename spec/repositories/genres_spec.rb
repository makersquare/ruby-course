require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Genres do
	subject { Songify::Repositories::Genres.new }
	let(:genre) { Songify::Genre.new('fake_genre') }
	let(:genre3) { Songify::Genre.new('fake_genre1') }

	before do
    subject.drop_table
  end

	it "adds a new genre to the database" do
		expect(genre.id).to be_nil
		result = Songify.genres_repo.save_a_genre(genre.name)
		result1 = Songify.genres_repo.get_all_genres
		expect(result).to eq(1)
		expect(result1.size).to eq(1)
		expect(result1.first.name).to eq('fake_genre')
	end

	it "checks for a genre in the database" do
		genre1 = Songify.genres_repo.save_a_genre(genre.name)
		genre2 = Songify.genres_repo.save_a_genre(genre3.name)
		result = Songify.genres_repo.has_genre?('fake_genre')
		result1 = Songify.genres_repo.has_genre?('metal')
		result2 = Songify.genres_repo.get_all_genres
		result3 = Songify.genres_repo.has_genre?('fake_genre test')
		expect(result2.size).to eq(2)
		expect(result).to eq(true)
		expect(result1).to eq(false)
	end

	it "gets all genres from the database" do
		genre1 = Songify.genres_repo.save_a_genre(genre.name)
		genre2 = Songify.genres_repo.save_a_genre(genre3.name)
		result = Songify.genres_repo.get_all_genres
		expect(result.size).to be(2)
	end

	it "retrieves genre ID by its name" do
		Songify.genres_repo.save_a_genre(genre.name)
		Songify.genres_repo.save_a_genre(genre3.name)
		result = Songify.genres_repo.get_genre_id('fake_genre')
		result1 = Songify.genres_repo.get_genre_id('polka')
		result2 = Songify.genres_repo.get_genre_id('fake_genre1')
		expect(result).to eq(1)
		expect(result1).to eq(false)
		expect(result2).to eq(2)
	end

	it "deletes a genre by its ID" do
		Songify.genres_repo.save_a_genre(genre.name)
		Songify.genres_repo.save_a_genre(genre.name)
		Songify.genres_repo.delete_a_genre(1)
		result = Songify.genres_repo.get_all_genres
		expect(result.first.id).to eq(2)
		expect(result.size).to eq(1)
	end

end