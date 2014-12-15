require_relative '../../spec_helper.rb'

describe 'Song' do
  let(:album_repo){Songify::AlbumRepo.new}
  before(:each) do
     album_repo.add_new_album(
        {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
        })
  end
  it 'has a name and an album id' do 
    result = Songify::Song.new({name: 'Prove It All Night', album_id: 1})
    expect(result.name).to eq('Prove It All Night')
    expect(result.album_id).to eq(1)
  end

  it 'has an embed link' do 
    result = Songify::Song.new({name: 'Streets of Fire', album_id: 1, embed: "https://embed.spotify.com/?uri=spotify:track:1PuHLoIL9LTev7T5ONv5zI"})
    expect(result.embed).to eq("https://embed.spotify.com/?uri=spotify:track:1PuHLoIL9LTev7T5ONv5zI")
  end
end