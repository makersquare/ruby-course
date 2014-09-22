require_relative '../spec_helper.rb'

describe Songify::Song do 
  let(:song) { Songify::Song.new('Fake Title', 'Fake Artist', 'Fake Album') }
  
  it 'will initialize with 3 attributes' do
    song = Songify::Song.new('Fake Title', 'Fake Artist', 'Fake Album')
    expect(song.title).to eq('Fake Title')
    expect(song.artist).to eq('Fake Artist')
    expect(song.album).to eq('Fake Album')
  end
end