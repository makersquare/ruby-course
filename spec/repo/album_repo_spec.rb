require_relative '../../spec_helper.rb'

describe 'the album repo' do 
  let(:album_repo){
    Songify::AlbumRepo.new
  }

  before(:each){
    album_repo.drop_table
    album_repo.create_table
  }

  describe 'add new album' do 
    it 'should be able to add an album' do 
      result = album_repo.add_new_album(
        {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
        })
      albums = album_repo.get_all_albums
      expect(result.title).to eq('Darkness on the Edge of Town')
      expect(albums.length).to eq(1)
    end
  end

  describe 'read, update, delete' do 
    before(:each) do 
      album_repo.add_new_album(
        {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
        })
      album_repo.add_new_album(
        {title: 'Pet Sounds',
        artist: 'The Beach Boys',
        cover: 'http://upload.wikimedia.org/wikipedia/en/b/bb/PetSoundsCover.jpg'
        })
      album_repo.add_new_album(
        {title: 'Run The Jewels 2',
        artist: 'Killer Mike & El P',
        cover: 'http://36.media.tumblr.com/4d1d4fa86923323f2686e9f8baacfd23/tumblr_ngbryfp3IH1t00btlo1_1280.jpg'
        })
      album_repo.add_new_album(
        {title: 'Run The Jewels 2',
        artist: 'Killer Mike & El P',
        cover: 'http://36.media.tumblr.com/4d1d4fa86923323f2686e9f8baacfd23/tumblr_ngbryfp3IH1t00btlo1_1280.jpg'
        })
    end

    it 'should be able to find an album by id' do
      result = album_repo.find_album({id: 1})
      expect(result.first.artist).to eq('Bruce Springsteen')
    end

    it 'should be able to find an album by title' do 
      result = album_repo.find_album({title: 'Pet Sounds'})
      expect(result.first.id).to eq(2)
    end

    it 'should be able to find multiple albums of the same title' do
      result = album_repo.find_album({title: "Run The Jewels 2"})
      res_arr = []
      expect(result.length).to eq(2)
      result.each{|x| res_arr << x.id}
      expect(res_arr).to eq([3,4])
    end
    
    describe 'update' do
      it 'can update an album' do 
        result = album_repo.update_album({id: 1, title: 'Born To Run', artist: 'Bruce Springsteen', cover: 'www.some_cover.jpg'})
        expect(result.title).to eq('Born To Run')
      end

      it 'can update the artist' do 
        result = album_repo.update_album({id: 2, artist: 'TBB', title: 'Pet Sounds', cover: 'some_cover.jpg'})
        expect(result.artist).to eq('TBB')
        expect(result.title).to eq('Pet Sounds')
      end

      it 'can update the cover' do 
        result = album_repo.update_album({id: 3, artist: 'Killer Mike & El P', title: 'RTJ2', cover: 'test.jpg'})
        expect(result.artist).to eq('Killer Mike & El P')
        expect(result.cover).to eq('test.jpg')
      end

      it 'can update multiple params' do 
        result = album_repo.update_album({id: 4, artist: 'KMEP', title: 'RTJ2', cover: 'some_cover.jpg'})
        expect(result.artist).to eq('KMEP')
        expect(result.title).to eq('RTJ2')
        expect(result.id).to eq(4)
      end

    end

    describe 'delete' do 
      it 'can delete an album' do 
        result = album_repo.delete_album({id: 2})
        expect(result.title).to eq('Pet Sounds')
        albums = album_repo.get_all_albums
        expect(albums.length).to eq(3)
      end
    end
  end


end