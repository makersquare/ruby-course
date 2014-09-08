require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs do
  let(:song) { Songify::Song.new('fake_title','fake_artist','fake_album','fake_genre') }
  let(:song1) { Songify::Song.new('fake_title_1','fake_artist_1','fake_album_1','fake_genre_1') }

  before(:each) do
    Songify.songs_repo.drop_table
    Songify.songs_repo.build_table
  end

  it 'adds a song to the songs table' do
    expect(song.id).to be_nil

    Songify.songs_repo.save_a_song(song)

    expect(song.id).to_not be_nil 
  end

  xit 'deletes a song from the songs table' do
    # Songify.songs_repo.delete_a_song(song)

    # expect(Songify.songs_repo.first).to be_nil
  end

  xit 'shows a song from the songs table' do
    # Songify.songs_repo.save_a_song(song)

    # requested_song = Songify.songs_repo.show_a_song(song)
    
    # expect(requested_song.title).to eq('fake_title')
  end

  it 'shows all songs from the songs table' do
    Songify.songs_repo.save_a_song(song)
    Songify.songs_repo.save_a_song(song1)

    all_songs = Songify.songs_repo.show_all_songs

    expect(all_songs.count).to eq(2)
  end
end