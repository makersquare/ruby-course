require_relative '../../spec_helper.rb'

describe 'the artist repo' do 
  before(:each) do 
    @artist_repo = Songify::ArtistRepo.new
  end

  it 'can add an artist to the database' do
    result = @artist_repo.add_new_artist({name: 'Willie Nelson'})
    artists = @artist_repo.get_all
    expect(result.name).to eq('Willie Nelson')
    expect(artists.length).to eq(1)
  end

  it 'can find an artist by name' do
    @artist_repo.add_new_artist({name: 'Johnny Cash'})
    result = @artist_repo.find_artist_by_name({name: 'Johnny Cash'})
    expect(result.name).to eq('Johnny Cash')
    expect(result.id).to eq(2)
  end

  it 'can edit an artist' do 
    result = @artist_repo.update_listing({id: 2, name: "John Cash"})
    expect(result.id).to eq(2)
    expect(result.name).to eq("John Cash")
  end

  it 'can delete an artist from the database' do
    @artist_repo.delete({id: 1})
    artists = @artist_repo.get_all
    expect(artists.length).to eq(1)
  end
end