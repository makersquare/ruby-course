require_relative '../spec_helper.rb'

describe Songify::Repositories::Song_Repo do 

  let(:repo) { Songify.song_repo}
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album') }

  describe '.get_song' do

    it 'retrieves a song from the database' do

      repo.drop_table

      id = 1
      repo.save_song(song)
      retrieved_song = repo.get_song(id)

      expect(retrieved_song.id).to eq (1)

    end

  end

  describe '.get_all_songs' do

    it 'retrieves all songs from the database' do

      repo.drop_table
      song1 = song
      song2 = Songify::Song.new("dingus", "Dangus", "dringus")
      song3 = Songify::Song.new("tim", "eric", "spagett")
      repo.save_song(song1)
      repo.save_song(song2)
      repo.save_song(song3)

      songs = repo.get_all_songs
      expect(songs[0].title).to eq("fake_title")
      expect(songs[1].title).to eq("dingus")
      expect(songs[2].title).to eq("tim")
      expect(songs.size).to eq (3)

    end

  end

  describe '.save_song' do

    it 'saves a song to the database' do

      repo.drop_table

      repo.save_song(song)
      songs = repo.build_songs(repo.entries)
      expect(songs[0].is_a?(Songify::Song)).to eq(true)

    end

  end

  describe '.delete_song' do

    it 'deletes a song from the database' do

        repo.drop_table

        repo.save_song(song)
        id = 1
        repo.delete_song(id)

        expect(repo.get_song(id)).to eq(nil)
    end

  end
  
end