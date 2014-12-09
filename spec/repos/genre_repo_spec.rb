require 'spec_helper'

describe Songify::GenreRepo do

  def genre_count
    repo.all(db).count
  end

  let(:repo) { Songify::GenreRepo }
  let(:db) { Songify.create_db_connection('songify_test') }

  before(:each) do
    Songify.clear_db(db)
  end

  it "gets all genres" do
    genre = repo.save(db, { 'name' => "The Ally" })
    genre = repo.save(db, { 'name' => "Barnway Blues" })

    genres = repo.all(db)
    expect(genres).to be_a Array
    expect(genres.count).to eq 2

    titles = genres.map {|u| u['name'] }
    expect(titles).to include "The Ally", "Barnway Blues"
  end

  it "creates genres" do
    expect(genre_count).to eq 0

    genre = repo.save(db, { 'name' => "The Ally" })
    expect(genre['id']).to_not be_nil
    expect(genre['name']).to eq "The Ally"

    # Check for persistence
    expect(genre_count).to eq 1

    genre = repo.all(db).first
    expect(genre['name']).to eq "The Ally"
  end

  it "requires a name" do
    expect { repo.save(db, {}) }.to raise_error(Songify::Errors::InvalidRecordData) {|e|
      expect(e.message).to match /name/
    }
  end


  it "finds genres" do
    genre = repo.save(db, { 'name' => "The Ally" })
    retrieved_song = repo.find(db, genre['id'])
    expect(retrieved_song['name']).to eq "The Ally"
  end

  it "updates genres" do
    song1 = repo.save(db, { 'name' => "The Ally" })
    song2 = repo.save(db, { 'id' => song1['id'], 'name' => "Alicia" })
    expect(song2['id']).to eq(song1['id'])
    expect(song2['name']).to eq "Alicia"

    # Check for persistence
    song3 = repo.find(db, song1['id'])
    expect(song3['name']).to eq "Alicia"
  end

end
