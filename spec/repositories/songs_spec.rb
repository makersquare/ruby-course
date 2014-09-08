require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs do
  let(:song) { song = Songify::Song.new("test title", "test artist", "test album") }
  let(:song2) { song = Songify::Song.new("test title 2", "test artist 2", "test album 2") }
  let(:song3) { song = Songify::Song.new("test title 3", "test artist 3", "test album 3") }

  before(:each) do
    Songify.songs_repo.drop_table
  end

  describe '#get_a_song' do
    it 'returns a song from the table with given id' do
      Songify.songs_repo.save_a_song(song)
      result = Songify.songs_repo.get_a_song(song.id)

      expect(result.size).to eq(1)
      expect(result.first.title).to eq("test title")
      expect(result.first.artist).to eq("test artist")
      expect(result.first.album).to eq("test album")
      expect(result.first.id).to be_true
    end
  end

  describe '#get_all_songs' do
    it 'returns all songs from the table' do
      Songify.songs_repo.save_a_song(song)
      Songify.songs_repo.save_a_song(song2)
      Songify.songs_repo.save_a_song(song3)
      result = Songify.songs_repo.get_all_songs

      expect(result.size).to eq(3)
      expect(result.first).to be_an_instance_of(Songify::Song)
    end
  end

  describe '#save_a_song' do
    it 'saves a song into the table using a song object' do
      expect(song.id).to be_nil
      Songify.songs_repo.save_a_song(song)
      expect(song.id).to be_true
    end
  end

  describe '#delete_a_song' do
    it 'deletes a given song using an id' do
      expect(song.id).to be_nil
      Songify.songs_repo.save_a_song(song)

      expect(song.id).to be_true
      Songify.songs_repo.delete_a_song(song)
      expect(song.id).to be_nil
    end
  end

end