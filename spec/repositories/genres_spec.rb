require_relative '../spec_helper.rb'

describe Songify::Repos::Genres do
  let(:genre) { Songify::Genre.new('pop')}
  let(:genres) { Songify.genres_repo}

  describe '.get_genre' do
    it 'returns the genre object of the genre id passed in' do
      genres.save_genre(genre)
      result = genres.get_genre(genre.id)

      expect(result).to be_a(Songify::Genre)
      expect(result.id).to eq(genre.id)
      expect(result.genre_name).to eq 'pop'
    end
  end

  describe '.get_all_genres' do
    it 'returns an array of all genre objects' do
      genre2 = Songify::Genre.new('rap')
      genres.save_genre(genre)
      genres.save_genre(genre2)
      result = genres.get_all_genres

      expect(result.size).to eq 2
      expect(result.last.id).to eq(genre2.id)
      expect(result.all? {|x| x.class == Songify::Genre}).to be_true
    end
  end

  describe '.save_genre' do
    it 'adds a genre to the database' do
      genres.save_genre(genre)
      result = genres.get_all_genres

      expect(result.first.genre_name).to eq 'pop'
    end

    it 'sets the id attribute of the genre object passed in' do
      genres.save_genre(genre)
      result = genres.get_all_genres

      expect(result.first.id).to eq 1
    end
  end

end