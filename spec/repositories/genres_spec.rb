require 'spec_helper.rb'

describe Songify::Repositories::Genres do

  before(:each) do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.build_table
    Songify.songs_repo.build_table
  end


  it 'will assign id to genre' do
    rock = Songify::Genre.new("rock")
    expect(rock.id).to be_nil

    Songify.genres_repo.save_genre(rock)
    expect(rock.id).to_not be_nil
  end

  it "will get genre by id" do
    rock = Songify::Genre.new("rock")
    Songify.genres_repo.save_genre(rock)

    result = Songify.genres_repo.get_genre_by_id(rock.id)

    expect(result).to be_a(Songify::Genre)
    expect(result.id).to eq(rock.id)
  end

  it 'will get all genres' do
    genre1 = Songify::Genre.new("rock")
    genre2 = Songify::Genre.new("rap")
    Songify.genres_repo.save_genre(genre1)
    Songify.genres_repo.save_genre(genre2)


    genre_list = Songify.genres_repo.get_all_genres

    expect(genre_list.size).to eq(2)
  end
    
end