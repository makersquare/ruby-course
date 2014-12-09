require 'spec_helper'

describe Songify::AlbumRepo do

  def album_count
    repo.all(db).count
  end

  let(:repo) { Songify::AlbumRepo }
  let(:db) { Songify.create_db_connection('songify_test') }

  before(:each) do
    Songify.clear_db(db)
  end

  it "gets all albums" do
    album = repo.save(db, { 'title' => "Allybum" })
    album = repo.save(db, { 'title' => "Bluesbum" })

    albums = repo.all(db)
    expect(albums).to be_a Array
    # expect(albums.count).to eq 2

    titles = albums.map {|u| u['title'] }
    expect(titles).to include "Allybum", "Bluesbum"
  end

  it "creates albums" do
    # expect(album_count).to eq 0
    
    album = repo.save(db, { 'title' => "Allybum" })
    # require 'pry-byebug'; binding.pry
    expect(album['id']).to_not be_nil
    expect(album['title']).to eq "Allybum"

    # Check for persistence
    expect(album_count).to eq 1

    album = repo.all(db).first
    expect(album['title']).to eq "Allybum"
  end

  it "requires a title" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /title/
    }
  end

  it "can be assigned genres" do
    gid_1 = Songify::GenreRepo.save(db, { 'name' => 'rock' })
    gid_2 = Songify::GenreRepo.save(db, { 'name' => 'avant-garde' })
    gid_3 = Songify::GenreRepo.save(db, { 'name' => 'jazz' })

    album_data = repo.save(db, {
      'title' => 'Suspicious Activity?',
      'genre_ids' => [gid_1['id'], gid_2['id'], gid_3['id']]
    })
    album = repo.find(db, album_data['id'])

    expect(album['genres'].count).to eq 3
    genre = album['genres'].first
    expect(genre).to be_a Hash
    expect(genre['id']).to_not be_nil
    expect(genre['name']).to_not be_nil

    names = album['genres'].map {|g| g['name'] }
    expect(names).to include 'rock', 'avant-garde', 'jazz'
  end

  it "finds albums" do
    album = repo.save(db, { 'title' => "Allybum" })
    retrieved_song = repo.find(db, album['id'])
    expect(retrieved_song['title']).to eq "Allybum"
  end

  it "updates albums" do
    song1 = repo.save(db, { 'title' => "Allybum" })
    song2 = repo.save(db, { 'id' => song1['id'], 'title' => "Alicia" })
    expect(song2['id']).to eq(song1['id'])
    expect(song2['title']).to eq "Alicia"

    # Check for persistence
    song3 = repo.find(db, song1['id'])
    expect(song3['title']).to eq "Alicia"
  end

end
