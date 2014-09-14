require_relative '../spec_helper.rb'

describe Songify::Song do
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album', 1) }

  before do
    Songify.songs_repo.drop_table
  end

  it 'will initialize with 3 attributes' do 
    expect(song.title).to eq('fake_title')
    expect(song.artist).to eq('fake_artist')
    expect(song.album).to eq('fake_album')
    expect(song.genre).to eq(1)
  end

end
