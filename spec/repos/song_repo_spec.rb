require 'spec_helper'

describe Songify::SongRepo do

  def song_count
    repo.all(db).count
  end

  let(:repo) { Songify::SongRepo }
  let(:db) { Songify.create_db_connection('songify_test') }

  before(:each) do
    Songify.clear_db(db)
    @album_id = Songify::AlbumRepo.save(db, { 'title' => "MegaCorps" })['id']
  end

  it "gets all songs" do
    song = repo.save(db, { 'album_id' => @album_id, 'title' => "The Ally" })
    song = repo.save(db, { 'album_id' => @album_id, 'title' => "Barnway Blues" })

    songs = repo.all(db)
    expect(songs).to be_a Array
    expect(songs.count).to eq 2

    titles = songs.map {|u| u['title'] }
    expect(titles).to include "The Ally", "Barnway Blues"
  end

  it "creates songs" do
    expect(song_count).to eq 0

    song = repo.save(db, { 'album_id' => @album_id, 'title' => "The Ally" })
    expect(song['id']).to_not be_nil
    expect(song['title']).to eq "The Ally"

    # Check for persistence
    expect(song_count).to eq 1

    song = repo.all(db).first
    expect(song['title']).to eq "The Ally"
  end

  it "requires a title" do
    expect { repo.save(db, {}) }.to raise_error(Songify::Errors::InvalidRecordData) {|e|
      expect(e.message).to match /title/
    }
  end

  it "requires an album id" do
    expect {
      repo.save(db, { 'title' => "The Ally" })
    }
    .to raise_error(Songify::Errors::InvalidRecordData) {|e|
      expect(e.message).to match /album_id/
    }
  end

  it "requires an album id that exists" do
    expect {
      repo.save(db, { 'album_id' => 999, 'title' => "The Ally" })
    }
    .to raise_error(Songify::Errors::InvalidRecordData) {|e|
      expect(e.message).to match /album_id/
    }
  end

  it "finds songs" do
    song = repo.save(db, { 'album_id' => @album_id, 'title' => "The Ally" })
    retrieved_song = repo.find(db, song['id'])
    expect(retrieved_song['title']).to eq "The Ally"
  end

  it "updates songs" do
    song1 = repo.save(db, { 'album_id' => @album_id, 'title' => "The Ally" })
    song2 = repo.save(db, { 'id' => song1['id'], 'title' => "Alicia" })
    expect(song2['id']).to eq(song1['id'])
    expect(song2['title']).to eq "Alicia"

    # Check for persistence
    song3 = repo.find(db, song1['id'])
    expect(song3['title']).to eq "Alicia"
  end

end
