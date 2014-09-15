require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Songs do
  # let(:song) { Songify::Song.new('fake_title','fake_artist','fake_album') }
  # let(:genre) { Songify::Genre.new('fake_genre') }
  let(:song1) { Songify::Song.new('fake_title_1','fake_artist_1','fake_album_1') }

  before(:each) do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.build_table
    Songify.songs_repo.build_table
    # Songify.genres_repo.save_genre(genre)
  end

  it 'adds a song to the songs table' do
    song = Songify::Song.new("title","artist","album")
    genre = Songify::Genre.new("genre")
    Songify.genres_repo.save_genre(genre)

    expect(song.id).to be_nil

    Songify.songs_repo.save_a_song(song,genre)

    expect(song.id).to_not be_nil 
  end

  it 'deletes a song from the songs table' do
    song = Songify::Song.new("title","artist","album")
    genre = Songify::Genre.new("genre")
    Songify.genres_repo.save_genre(genre)

    Songify.songs_repo.save_a_song(song, genre)
    before_del = Songify.songs_repo.show_all_songs
    expect(before_del.count).to eq(1)

    Songify.songs_repo.delete_a_song(song)
    after_del = Songify.songs_repo.show_all_songs
    expect(after_del.count).to eq(0)
  end

  it 'shows a song from the songs table' do
    song = Songify::Song.new("title","artist","album")
    genre = Songify::Genre.new("genre")
    Songify.genres_repo.save_genre(genre)

    Songify.songs_repo.save_a_song(song, genre)

    req_song = Songify.songs_repo.show_a_song(song)

    expect(req_song.title).to eq('title')
  end

  it 'shows all songs from the songs table' do
    song = Songify::Song.new("title","artist","album")
    song1 = Songify::Song.new("title1","artist1","album1")
    genre = Songify::Genre.new("genre")
    Songify.genres_repo.save_genre(genre)
    Songify.songs_repo.save_a_song(song, genre)
    Songify.songs_repo.save_a_song(song1, genre)


    all_songs = Songify.songs_repo.show_all_songs

    expect(all_songs.count).to eq(2)
    expect(all_songs.first.title).to eq('title')
    expect(all_songs.last.title).to eq('title1')
  end
end