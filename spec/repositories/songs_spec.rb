require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs do
  before(:each) do
    @genre = Songify::Genre.new("asdf")
    Songify.genres_repo.save_a_genre(@genre)
    id = @genre.id
    @song = Songify::Song.new("test title", "test artist", "test album", id)
    @song2 = Songify::Song.new("test title 2", "test artist 2", "test album 2", id)
    @song3 = Songify::Song.new("test title 3", "test artist 3", "test album 3", id)
  end


  describe '#get_a_song' do
    it 'returns a song from the table with given id' do
      Songify.genres_repo.save_a_genre(@genre)
      Songify.songs_repo.save_a_song(@song)
      result = Songify.songs_repo.get_a_song(@song.id)

      expect(result.title).to eq(@song.title)
      expect(result.artist).to eq(@song.artist)
      expect(result.album).to eq(@song.album)
      expect(result.id).to eq(@song.id)
    end
  end

  describe '#get_all_songs' do
    it 'returns all songs from the table' do
      Songify.genres_repo.save_a_genre(@genre)
      binding.pry
      Songify.songs_repo.save_a_song(@song)
      Songify.songs_repo.save_a_song(@song2)
      Songify.songs_repo.save_a_song(@song3)
      result = Songify.songs_repo.get_all_songs

      expect(result.size).to eq(3)
      expect(result.first).to be_an_instance_of(Songify::Song)
    end
  end

  describe '#save_a_song' do
    it 'saves a song into the table using a song object' do
      Songify.genres_repo.save_a_genre(@genre)
      expect(@song.id).to be_nil
      Songify.songs_repo.save_a_song(@song)
      expect(@song.id).to_not be_nil
    end
  end

  describe '#delete_a_song' do
    it 'deletes a given song using an id' do
      Songify.genres_repo.save_a_genre(@genre)
      expect(@song.id).to be_nil
      Songify.songs_repo.save_a_song(@song)
      result = Songify.songs_repo.get_all_songs
      expect(result.size).to eq(1)

      Songify.songs_repo.delete_a_song(@song.id)
      result = Songify.songs_repo.get_all_songs
      expect(result.size).to eq(0)
    end
  end

end