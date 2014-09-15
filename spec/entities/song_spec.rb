require_relative '../spec_helper.rb'

describe Songify::Song do 
  let(:song){Songify::Song.new('artist','title','albumA',5)}

  it 'Will initialize with four attributes' do
    expect(song.artist).to eq('artist')
    expect(song.title).to eq('title')
    expect(song.album).to eq('albumA')
    expect(song.length).to eq(5)
  end
end

