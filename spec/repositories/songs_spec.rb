require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  let(:song) { song = Songify::Song.new("test title", "test artist", "test album") }

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