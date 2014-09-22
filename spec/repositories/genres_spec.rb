require_relative "../spec_helper.rb"

describe Songify::Repo::Genres do  
  before(:each) do
   Songify.songs_repo.drop_table
   Songify.genres_repo.drop_table
   Songify.genres_repo.build_table
   Songify.songs_repo.build_table

 end

  let(:genres_test) {Songify.genres_repo}
  let(:genre1) {Songify::Genre.new("genre1")}
  let(:genre2) {Songify::Genre.new("genre2")}

  it "saves a Genre to the database" do
    expect(genre1.id).to be_nil
   
    genres_test.save_genre(genre1)

    expect(genre1.id).not_to be_nil

  end

  it "gets a Genre from the database by ID" do
    genres_test.save_genre(genre1)
    genres_test.save_genre(genre2)

    result = genres_test.get_genre(genre1.id)

    expect(result.name).to eq ("genre1") 
    expect(result).to be_a(Songify::Genre)
  end

  it "gets all genres from the database" do
    genres_test.save_genre(genre1)
    genres_test.save_genre(genre2)

    result = genres_test.get_all_genres

    expect(result.first.name).to eq("genre1")
    expect(result.last.name).to eq("genre2")

  end

  

  
end

