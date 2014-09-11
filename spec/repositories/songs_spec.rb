require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
  let(:genre) { Songify::Genre.new('pop')}
  let(:genres) { Songify.genres_repo}
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album')}
  let(:songs) { Songify.songs_repo}

  describe '.get_song' do
    it 'returns the song object of the song id passed in' do
      genres.save_genre(genre)
      songs.save_song(song, genre)
      result = songs.get_song(song.id)

      expect(result).to be_a(Songify::Song)
      expect(result.id).to eq(song.id)
      expect(result.genre_id).to eq(genre.id)
    end
  end

  describe '.get_all_songs' do
    it 'returns an array of all song objects' do
      song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
      genres.save_genre(genre)
      songs.save_song(song, genre)
      songs.save_song(song2, genre)
      result = songs.get_all_songs

      expect(result.size).to eq 2
      expect(result.last.id).to eq 2
      expect(result.all? {|x| x.class == Songify::Song}).to be_true
    end
  end

  describe '.save_song' do
    it 'adds a song to the database' do
      genres.save_genre(genre)
      songs.save_song(song, genre)
      result = songs.get_all_songs

      expect(result.first.title).to eq 'fake_title'
    end

    it 'sets the id attribute of the song object passed in' do
      genres.save_genre(genre)
      songs.save_song(song, genre)
      result = songs.get_all_songs

      expect(result.first.id).to eq 1
    end
  end

  describe '.delete_song' do
    it 'removes a song from the database' do
      genres.save_genre(genre)
      song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
      songs.save_song(song, genre)
      songs.save_song(song2, genre)

      songs.delete_song(song.id)
      result = songs.get_all_songs

      expect(result.size).to eq 1
      expect(result.first.id).to eq(song2.id)
      expect(result.first.title).to eq 'fake_title2'
    end
  end

end