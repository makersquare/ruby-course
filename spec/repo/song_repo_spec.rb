require_relative '../../spec_helper.rb'

describe 'the song repo' do 
  let(:album_repo){
    Songify::AlbumRepo.new
  }
  let(:song_repo){
    Songify::SongRepo.new
  }
  before(:each){
    album_repo.drop_table
    album_repo.create_table
    song_repo.drop_table
    song_repo.create_table
    album_repo.add_new_album(
      {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
      })
  }
  describe 'add new song' do 
    it 'should be able to add a song associated with a table' do 
      result = song_repo.add_new_song({name: 'Prove It All Night', album_id: 1, embed:'http://hello.world'})
      songs = song_repo.get_all_songs
      expect(result.name).to eq('Prove It All Night')
      expect(result.album_id).to eq(1)
      expect(result.embed).to eq('http://hello.world')
      expect(songs.length).to eq(1)
    end
  end

  describe 'read, update, delete' do 
    before(:each) do 
        album_repo.add_new_album(
        {title: 'Pet Sounds',
        artist: 'The Beach Boys',
        cover: 'http://upload.wikimedia.org/wikipedia/en/b/bb/PetSoundsCover.jpg'
        })
        song_repo.add_new_song(
        {name: 'Sloop John B',
          album_id: 2
        })
        song_repo.add_new_song(
        {name: 'Something in the Night',
          album_id: 1
        })
    end
    it 'can get all songs' do 
      songs = song_repo.get_all_songs
      expect(songs.length).to eq(2)
      expect(songs[0].name).to eq('Sloop John B')
      expect(songs[1].name).to eq('Something in the Night')
    end

    it 'can find a song by id' do
      result = song_repo.find_songs({id: 1})
      expect(result.first.name).to eq('Sloop John B') 
    end

    it 'can find a song by name' do
      result = song_repo.find_songs({name: 'Something in the Night'})
      expect(result.first.album_id).to eq(1)
    end

    it 'can find multiple songs of the same name' do
      song_repo.add_new_song({name: 'Sloop John B', album_id: 1}) 
      result = song_repo.find_songs({name: 'Sloop John B'})
      expect(result[0].album_id).to eq(2)
      expect(result[1].album_id).to eq(1)
    end

    it 'can find all songs from an album' do 
      song_repo.add_new_song({name: 'Prove It All Night', album_id: 1})
      result = song_repo.find_songs({album_id: 1})
      expect(result.length).to eq(2)
      expect(result[0].name).to eq('Something in the Night')
      expect(result[1].name).to eq('Prove It All Night')
    end

    it 'can update a song' do 
      result = song_repo.update_song({id: 1, album_id: 1, name: 'Sloop John B'})
      album = song_repo.find_songs({album_id: 1})
      expect(album.length).to eq(2)
      expect(result.id).to eq(1)
      expect(result.name).to eq('Sloop John B')
    end

    it 'can delete a song' do 
      result = song_repo.delete_song({id: 1})
      songs = song_repo.get_all_songs
      expect(songs.length).to eq(1)
      expect(result.name).to eq('Sloop John B')
    end
  end
end