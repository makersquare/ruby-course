require_relative '../../spec_helper.rb'

describe 'the artist repo' do 
  let(:artist_repo) {
    Songify::ArtistRepo.new
  }
  before(:each) do 
    artist_repo.drop_table
    artist_repo.create_table
  end

  describe 'adding' do 
    it 'can add an artist to the database' do
      result = artist_repo.add_new_artist({name: 'Willie Nelson'})
      artists = artist_repo.get_all
      expect(result.name).to eq('Willie Nelson')
      expect(artists.length).to eq(1)
    end
  end

  describe 'finding' do 
    before(:each) do 
    artist_repo.add_new_artist({name: 'Willie Nelson'})
    artist_repo.add_new_artist({name: 'Johnny Cash'})
    end

    it 'can find an artist by name' do
      result = artist_repo.find_artist_by_name({name: 'Johnny Cash'})
      expect(result.name).to eq('Johnny Cash')
      expect(result.id).to eq(2)
    end

    xit 'can find an artist by id' do 
    end

    xit 'can find all artists' do 
    end
  end

  describe 'editing' do 
    it 'can edit an artist' do 
      artist_repo.add_new_artist({name: 'Johnny Cash'})
      result = artist_repo.update_artist({id: 1, name: "John Cash"})
      expect(result.id).to eq(1)
      expect(result.name).to eq("John Cash")
    end
  end
  

  describe 'delete' do 
    before(:each) do 
      artist_repo.add_new_artist({name: 'Willie Nelson'})
      artist_repo.add_new_artist({name: 'Johnny Cash'})
    end

    it 'can delete an artist from the database using id' do
      artist_repo.delete_artist({id: 1})
      artists = artist_repo.get_all
      expect(artists.length).to eq(1)
    end

    it 'can delete an artist from the database using name' do 
      artist_repo.delete_artist({name: 'Johhny Cash'})
      artists = artist_repo.get_all
      expect(artists.length).to eq(1)
    end
  end

end