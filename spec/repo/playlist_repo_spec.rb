require_relative '../../spec_helper.rb'

describe 'the playlist repo' do 
  let(:playlist_repo){
    Songify::PlaylistRepo.new
  }
  let(:song_repo){
    Songify::SongRepo.new
  }
  let(:album_repo){
    Songify::AlbumRepo.new
  }
  before(:each){
    album_repo.drop_table
    album_repo.create_table
    song_repo.drop_table
    song_repo.create_table
    playlist_repo.drop_table
    playlist_repo.create_table
    playlist_repo.drop_join
    playlist_repo.create_join
    album_repo.add_new_album(
      {title: 'Darkness on the Edge of Town',
        artist: 'Bruce Springsteen',
        cover: 'http://upload.wikimedia.org/wikipedia/en/a/af/BruceSpringsteenDarknessontheEdgeofTown.jpg'
      })
    song_repo.add_new_song({name: 'Prove It All Night', album_id: 1, embed:'http://hello.world'})
    song_repo.add_new_song({name: 'Song 2', album_id: 1, embed:"another.html"})
    song_repo.add_new_song({name: 'third song', album_id: 1, embed:"more embed"})
  }

  describe 'add new playlist' do 
    it 'can create a playlist' do
      result = playlist_repo.add_new_playlist({title: 'My Sweet Playlist'})
      expect(result.id).to eq(1)
      playlists = playlist_repo.get_all_playlists
      expect(playlists.length).to eq(1)
    end
  end

  describe 'read,edit,delete' do 

    before(:each){
      playlist_repo.add_new_playlist({title: "My chillass playlist"})
    }
    it 'can find a playlist' do 
      result = playlist_repo.find_playlist({id: 1})
      expect(result.first.title).to eq("My chillass playlist")
    end

    it 'can get all playlists' do 
      playlist_repo.add_new_playlist({title: "My second playlist"})
      result = playlist_repo.get_all_playlists
      expect(result.length).to eq(2)
    end

    it 'can add a song to two different playlists' do 
      playlist_repo.add_new_playlist({title: "Second sweet playlist"})
      playlist_repo.add_song_to_playlist({song_id: 1, playlist_id: 1})
      playlist_repo.add_song_to_playlist({song_id: 1, playlist_id: 2})
      one = song_repo.get_songs_in_playlist({playlist_id: 1})
      two = song_repo.get_songs_in_playlist({playlist_id: 2})
      expect(one.first.name).to eq('Prove It All Night')
      expect(two.first.name).to eq('Prove It All Night')
    end

    it 'can get all the playlists a song appears on' do 
      playlist_repo.add_new_playlist({title: "Second playlist"})
      playlist_repo.add_song_to_playlist({song_id: 1, playlist_id: 1})
      playlist_repo.add_song_to_playlist({song_id: 1, playlist_id: 2})
      result = playlist_repo.get_playlists_for_songs({song_id: 1})
      expect(result.length).to eq(2)
      expect(result.first.title).to eq('My chillass playlist')
      expect(result[1].title).to eq('Second playlist')
    end

    describe 'edit/update' do 
      it 'can update the name of a playlist' do 
        result = playlist_repo.update_playlist({id: 1, title: 'edited'})
        expect(result.title).to eq('edited')
      end

    describe 'delete' do 
      it 'can delete a playlist' do
        playlist_repo.add_new_playlist({title: "Second playlist"})
        playlist_repo.delete_playlist({id: 1})
        expect(playlist_repo.get_all_playlists.length).to eq(1)
      end

      it 'can delete a join' do
        playlist_repo.add_song_to_playlist({song_id: 1, playlist_id: 1})
        playlist_repo.add_song_to_playlist({song_id: 2, playlist_id: 1})
        playlist_repo.delete_join({song_id: 1, playlist_id: 1})
        result = song_repo.get_songs_in_playlist({playlist_id: 1})
        expect(result.length).to eq(1)
      end
    end
    end

  end
end