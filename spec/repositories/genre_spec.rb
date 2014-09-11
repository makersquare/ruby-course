require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do
  let(:genre1) { genre = Songify::Genre.new("rap") }
  let(:genre2) { genre = Songify::Genre.new("country") }
  let(:genre3) { genre = Songify::Genre.new("classical") }

  before(:each) do
    Songify.genres_repo.drop_table
  end

  describe '#get_a_genre' do
    it 'returns a genre by given id' do

    end
  end

  describe '#save_a_genre' do
    it 'saves a genre in the genres table' do
      expect(genre1.id).to be_nil
      Songify.genres_repo.save_a_genre(genre1)
      expect(genre1.id).to_not be_nil
    end
  end
end