require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do 
  let(:genre) { Songify::Genre.new('Fake Genre') }

  it "adds a genre" do
    genre_object = Songify::Genre.new("Fake Genre")
    Songify.genres_repo.save_a_genre(genre_object)
    expect(genre_object.id).should_not be_nil
  end

  it "saves a genre" do
    # binding.pry
    Songify.genres_repo.truncate_table
    genre_object = Songify::Genre.new("Fake Genre")
    genre_object2 = Songify::Genre.new("Fake Genre2")

    #saving the genres the variables will be equal to the genres ID's
    y = Songify.genres_repo.save_a_genre(genre_object)
    x = Songify.genres_repo.save_a_genre(genre_object2)

    #pulling the objects out of the database
    y = Songify.genres_repo.get_a_genre_by_id(y)
    x = Songify.genres_repo.get_a_genre_by_id(x)

    expect(y.name).to eq("Fake Genre")
      expect(x.name).to eq("Fake Genre2")
  end

  it "deletes a genre" do 
    Songify.genres_repo.truncate_table
    genre_object = Songify::Genre.new("Fake Title")
    genre_object1 = Songify::Genre.new("Fake Title1")
    Songify.genres_repo.save_a_genre(genre_object)
    Songify.genres_repo.save_a_genre(genre_object1)
    y = Songify.genres_repo.get_all_genres
    expect(y.length).to eq(2)
    Songify.genres_repo.delete_a_genre(genre_object1.id)
    y = Songify.genres_repo.get_all_genres
    expect(y.length).to eq(1)
  end

  it "gets a genre by name" do
    genre_object = Songify::Genre.new("Fake Title")
    genre_object1 = Songify::Genre.new("Fake Title1")
    Songify.genres_repo.save_a_genre(genre_object)
    Songify.genres_repo.save_a_genre(genre_object1)

    y = Songify.genres_repo.get_a_genre_by_name(genre_object1.name)

    expect(y.id).to_not be_nil
  end

  it "gets all genres" do
    Songify.genres_repo.truncate_table

    genre_object = Songify::Genre.new("Fake Title")
    genre_object1 = Songify::Genre.new("Fake Title1")
    genre_object2 = Songify::Genre.new("Fake Title2")
    Songify.genres_repo.save_a_genre(genre_object)
    Songify.genres_repo.save_a_genre(genre_object1)
    Songify.genres_repo.save_a_genre(genre_object2)


    y = Songify.genres_repo.get_all_genres
    expect(y.length).to eq(3)
  end
end