require_relative '../spec_helper.rb'

describe Songify::Repositories::Genre_Repo do 

  let(:repo) { Songify.genre_repo}
  let(:genre) { Songify::Genre.new('death metal') }

  describe '.get_genre' do

    it 'retrieves a genre from the database' do

      repo.drop_table

      id = 1
      repo.save_genre(genre)
      retrieved_genre = repo.get_genre(id)

      expect(retrieved_genre.id).to eq (1)

    end

  end

  describe '.get_all_genres' do

    it 'retrieves all genres from the database' do

      repo.drop_table
      genre1 = genre
      genre2 = Songify::Genre.new("country")
      genre3 = Songify::Genre.new("pop")
      repo.save_genre(genre1)
      repo.save_genre(genre2)
      repo.save_genre(genre3)

      genres = repo.get_all_genres
      expect(genres[0].title).to eq("death metal")
      expect(genres[1].title).to eq("country")
      expect(genres[2].title).to eq("pop")
      expect(genres.size).to eq (3)

    end

  end

  describe '.save_genre' do

    it 'saves a genre to the database' do

      repo.drop_table

      repo.save_genre(genre)
      genres = repo.build_genres(repo.entries)
      expect(genres[0].is_a?(Songify::Genre)).to eq(true)

    end

   end

  describe '.delete_genre' do

    it 'deletes a genre from the database' do

        repo.drop_table

        repo.save_genre(genre)
        id = 1
        repo.delete_genre(id)

        expect(repo.get_genre(id)).to eq(nil)
    end

  end
  
end