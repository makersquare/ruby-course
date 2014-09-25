require_relative '../spec_helper.rb'

describe Songify::Repos::Genres do
let (:subject) { Songify::Repos::Genres.new('songify_test') }

  before(:each) do
    subject.drop_table
  end

  after do
    subject.drop_table
  end

  it "saves a genre" do
    answer = subject.save_a_genre(Songify::Genre.new(genre:"rock"))
    expect(answer).to eq(1)
  end

  it "gets a genre by id" do
    answer = subject.save_a_genre(Songify::Genre.new(genre:"rock"))
    expect(answer).to eq(1)
    result = subject.get_a_genre(answer)
    expect(result.genre).to eq("Rock")
  end

  it "gets a genre by name" do
    answer = subject.save_a_genre(Songify::Genre.new(genre:"Rock"))
    result = subject.get_a_genre_by_name("Rock")
    expect(result.id).to eq(1)
  end

  it "gets all genres" do
    subject.save_a_genre(Songify::Genre.new(genre:"Rock"))
    subject.save_a_genre(Songify::Genre.new(genre:"Punk"))
    result = subject.get_all_genres
    
    expect(result.first.genre).to eq("Rock")
    expect(result.last.genre).to eq("Punk")
  end

  it "deletes a genre" do
    subject.save_a_genre(Songify::Genre.new(genre:"Rock"))
    subject.save_a_genre(Songify::Genre.new(genre:"Punk"))
    subject.delete_a_genre(1)
    result = subject.get_all_genres
    expect(result.first.genre).to eq("Punk")
    expect(result.length).to eq(1)
  end

  it "does not allow multiple genres with the same name" do
    subject.save_a_genre(Songify::Genre.new(genre:"Rock"))
    subject.save_a_genre(Songify::Genre.new(genre:"rock"))
    result = subject.get_all_genres
    expect(result.length).to eq(1)
    expect(result.first.genre).to eq("Rock")
    expect(result.first.id).to eq(1)
  end

end





