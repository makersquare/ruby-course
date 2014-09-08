require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
  before(:each) {Songify.songs_repo.drop_table}
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album', 'fake_genre', 'fake_length')}
  let(:songs) { Songify.songs_repo}

  describe '.log' do
    it 'returns an array of song objects' do      
      songs.save_song(song)
      result = songs.log

      expect(result.first).to be_a(Songify::Song)
    end
  end

  describe '.save_song' do
    it 'adds a song to the database' do
      songs.save_song(song)
      result = songs.log

      expect(result.first.title).to eq 'fake_title'
    end

    it 'sets the id attribute of the song object passed in' do
      songs.save_song(song)
      result = songs.log

      expect(result.first.id).to eq 1
    end
  end

end