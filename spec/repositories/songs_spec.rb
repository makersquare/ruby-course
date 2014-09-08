require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  before(:each) do
    Songify.songs_repo.drop_table
  end

  describe '#get_a_song' do
    it 'returns a song from the table with given id' do
    end
  end

  describe '#get_all_songs' do
    it 'returns all songs from the table' do

    end
  end

  describe '#save_a_song' do
    it 'saves a song into the table using a song object' do
      song = Songify::Song.new("test title", "test artist", "test album")
      expect(song.id).to be_nil
      Songify.songs_repo.save_a_song(song)
      expect(song.id).to be_true
    end
  end

  describe '#delete_a_song' do
    it 'deletes a given song using an id' do

    end
  end

end