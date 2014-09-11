require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do
  let(:genre1) { genre = Songify::Genre.new("rap") }
  let(:genre2) { genre = Songify::Genre.new("country") }
  let(:genre3) { genre = Songify::Genre.new("classical") }

  describe '#get_a_genre_by_id' do
    it 'returns a genre by given id' do
      Songify.genres_repo.save_a_genre(genre1)
      result = Songify.genres_repo.get_a_genre_by_id(genre1.id)
      expect(result.name).to eq("rap")
    end
  end

  describe '#get_a_genre_by_name' do
    it 'returns a genre by given name' do
      Songify.genres_repo.save_a_genre(genre2)
      result = Songify.genres_repo.get_a_genre_by_name(genre2.name)
      expect(result.name).to eq("country")
    end
  end

  describe '#get_all_genres' do
    it 'returns all of the genres in the database' do
      Songify.genres_repo.save_a_genre(genre1)
      Songify.genres_repo.save_a_genre(genre2)
      Songify.genres_repo.save_a_genre(genre3)
      result = Songify.genres_repo.get_all_genres
      expect(result.size).to eq(3)
      expect(result.last.name).to eq("classical")
      expect(result.first).to be_an_instance_of(Songify::Genre)
    end
  end

  describe '#save_a_genre' do
    it 'saves a genre in the genres table' do
      expect(genre1.id).to be_nil
      Songify.genres_repo.save_a_genre(genre1)
      expect(genre1.id).to_not be_nil
    end
  end

  describe '#delete_a_genre' do
    it 'deletes a genre by id' do
      Songify.genres_repo.save_a_genre(genre1)
      Songify.genres_repo.save_a_genre(genre2)
      Songify.genres_repo.save_a_genre(genre3)
      result = Songify.genres_repo.get_all_genres
      expect(result.size).to eq(3)
      Songify.genres_repo.delete_a_genre(genre1.id)
      result = Songify.genres_repo.get_all_genres
      expect(result.size).to eq(2)
    end
  end
end