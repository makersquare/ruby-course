require_relative '../../spec_helper.rb'

describe 'playlist' do 
  let(:playlist){Songify::Playlist.new({id: 1, title: "My Chill Playlist"})}

  it 'has an id and a title' do 
    expect(playlist.id).to eq(1)
    expect(playlist.title).to eq("My Chill Playlist")
  end
end