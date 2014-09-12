require_relative '../spec_helper.rb'

describe Songify::Song do

  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album', 1) }

  it 'will initialize with 4 attributes' do
	    # song = Songify::Song.new('fake_title', 'fake_artist' 'fake_album')
	    expect(song.title).to eq('fake_title')
	    expect(song.artist).to eq('fake_artist')
	    expect(song.album).to eq('fake_album')
	    expect(song.genre_id).to eq(1)
  end
end