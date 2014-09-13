require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Genres do 

  let(:genre) { Songify::Genre.new('Whale Music') }
  
  before do
    Songify.genres_repo.drop_table
  end

  it 'saves a genre' do 
    expect(genre.id).to be(nil)

    new_genre = Songify.genres_repo.save_a_genre(genre)

    expect(new_genre.first.id).to_not be(nil)
  end

  it 'gets a genre' do 
    Songify.genres_repo.save_a_genre(genre)
    # binding.pry
    genre_id = genre.id
    retrieved_genre = Songify.genres_repo.get_a_genre(genre_id)

    expect(retrieved_genre.first.id).to eq(genre.id)
  end

  it 'gets all genres' do 
    genre2 = Songify::Genre.new('Relaxing Polka')
    genre3 = Songify::Genre.new('Punk Rock')
    Songify.genres_repo.save_a_genre(genre, genre2, genre3)

    expect(Songify.genres_repo.get_all_genres.length).to eq(3)
  end

  it 'deletes a genre' do 
    genre2 = Songify::Genre.new('Relaxing Polka')
    genre3 = Songify::Genre.new('Punk Rock')
    Songify.genres_repo.save_a_genre(genre, genre2, genre3)
    Songify.genres_repo.delete_a_genre(genre3.id)
    # binding.pry

    expect(Songify.genres_repo.get_all_genres.length).to eq(2)
  end
end



