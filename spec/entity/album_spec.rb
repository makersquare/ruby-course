require_relative '../../spec_helper.rb'

describe 'an album' do
  let(:album) {Songify::Album.new(
    {title: 'Darkness on the Edge of Town', 
    artist: 'Bruce Springsteen', 
    cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
    })}
  it 'has a title, an artist, and a cover' do 
    expect(album.title).to eq('Darkness on the Edge of Town')
    expect(album.artist).to eq('Bruce Springsteen')
    expect(album.cover).to eq('http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg')
  end
end