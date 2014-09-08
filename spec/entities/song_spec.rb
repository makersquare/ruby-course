require_relative '../spec_helper.rb'

describe Songify::Song do 

  it 'will initialize with three attributes' do

    song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')

    expect(song.title). to eq('fake_title')
    expect(song.artist). to eq('fake_artist')
    expect(song.album). to eq('fake_album')

  end

end
