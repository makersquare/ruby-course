require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs do
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album') }
  
  it "adds a song to the database" do
    Songify.songs_repo.drop_table
    Songify.songs_repo.save_a_song(song)
    result = Songify.songs_repo.get_all_songs
    expect(result.size).to eq(1)
  end

  it "gets all songs from the database" do
    Songify.songs_repo.save_a_song(song)
    Songify.songs_repo.save_a_song(song)
    Songify.songs_repo.save_a_song(song)
    result = Songify.songs_repo.get_all_songs
    expect(result.size).to eq(4)
  end

  it "selects a song by its Song ID" do
    result = Songify.songs_repo.get_a_song(4)
    expect(result.size).to eq(1)

    expect(result.first.class).to be(Songify::Song)
  end


  it "deletes a song from the database by its Song ID" do
    Songify.songs_repo.delete_a_song(3)
    result = Songify.songs_repo.get_all_songs
    expect(result.size).to eq(3)
    expect(result[0].id).to eq(1)
    expect(result[1].id).to eq(2)
    expect(result[2].id).to eq(4)
  end

  it "check that the next song added will have an ID of 5" do
    Songify.songs_repo.save_a_song(song)
    result = Songify.songs_repo.get_all_songs
    expect(result.last.id).to eq(5)
  end

end