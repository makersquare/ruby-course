require_relative '../spec_helper.rb'

describe Songify::Repositories::Song_Repo do 

  let(:repo) { Songify.song_repo}
  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album') }

  describe '.get_song' do

    xit 'retrieves a song from the database' do


    end

  end

  describe '.get_all_songs' do

    xit 'retrieves all songs from the database' do

    end

  end

  describe '.save_song' do

    it 'saves a song to the database' do

      repo.save_song(song)
      songs = repo.build_songs(repo.entries)
      expect(songs[0].is_a?(Songify::Song)).to eq(true)

    end

  end

  describe '.delete_song' do

    xit 'deletes a song from the database'

  end
  
end