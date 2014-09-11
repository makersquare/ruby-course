require_relative '../spec_helper.rb'

describe Songify::Song do
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album', 'fake_genre')}
  
  describe '.initialize' do
    it 'will initialize with 4 attributes and id set to nil' do
      expect(song.title).to eq 'fake_title'
      expect(song.artist).to eq 'fake_artist'
      expect(song.album).to eq 'fake_album'
      expect(song.genre).to eq 'fake_genre'
      expect(song.id).to be_nil
    end
  end

end