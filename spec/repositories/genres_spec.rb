require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do
  let(:genres) { Songify.genres }
  let(:genre) { Songify::Genre.new('Oldies') }
  let(:genre2) { Songify::Genre.new('Pop') }
  let(:genre3) { Songify::Genre.new('Classic Rock') }

  it "Adds a genre to the genres table and checks get all genres method" do
    expect(genre.id).to be_nil

    genres.add_genre(genre)
    genres.add_genre(genre2)
    genres.add_genre(genre3)

    genre_list = genres.get_all_genres

    expect(genre.id).to_not be_nil
    expect(genres.class).to eq(Songify::Repositories::Genres)
    expect(genre_list.class).to eq(Array)
    expect(genre_list.length).to eq(3)
  end

  it "Returns a specific genre by id" do
    genres.add_genre(genre)
    genres.add_genre(genre2)
    genres.add_genre(genre3)

    genre_list = genres.get_all_genres

    oldies = genres.get_genre(genre_list.first.id)
    pop = genres.get_genre(genre_list[1].id)
    classic_rock = genres.get_genre(genre_list[2].id)

    expect(oldies.first["name"]).to eq('Oldies')
    expect(pop.first["id"]).to eq("2")
    expect(classic_rock.first["name"]).to eq("Classic Rock")
  end

  it "Deletes a genre from the table" do
    genres.add_genre(genre)
    genres.add_genre(genre2)
    genres.add_genre(genre3)

    genre_list = genres.get_all_genres
    expect(genre_list.length).to eq(3)

    genres.delete_genre(genre_list.first.id)

    genre_list = genres.get_all_genres
    expect(genre_list.length).to eq(2)
  end
  
end