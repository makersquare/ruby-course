require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do

  before(:each) do
    Songify.songs_repo.drop_and_rebuild_table
  end

  it 'will save a song' do
    song = Songify::Song.new("fake_title", "fake_artist", "fake_album")

    expect(song.id).to be_nil

    Songify.songs_repo.save_a_song(song)

    # expect(result.length).to eq(1)
    expect(song.id).to_not be_nil
  end 

  it 'will get all songs' do
    song1 = Songify::Song.new("fake_title", "fake_artist", "fake_album")
    song2 = Songify::Song.new("fake_title_2", "fake_artist_2", "fake_album_2")

    Songify.songs_repo.save_a_song(song1)
    Songify.songs_repo.save_a_song(song2)

    result = Songify.songs_repo.get_all_songs

    expect(result.length).to eq(2)
  end

  it 'will get a song by id' do
    song1 = Songify::Song.new("fake_title", "fake_artist", "fake_album")
    song2 = Songify::Song.new("fake_title_2", "fake_artist_2", "fake_album_2")

    Songify.songs_repo.save_a_song(song1)
    Songify.songs_repo.save_a_song(song2)

    result = Songify.songs_repo.get_a_song(song2.id)

    expect(result.first.title).to eq("fake_title_2")
  end

  it 'will delete a song by id' do
    song1 = Songify::Song.new("fake_title_1", "fake_artist_1", "fake_album_1")
    song2 = Songify::Song.new("fake_title_2", "fake_artist_2", "fake_album_2")

    Songify.songs_repo.save_a_song(song1)
    Songify.songs_repo.save_a_song(song2)

    Songify.songs_repo.delete_a_song(song2.id)

    result = Songify.songs_repo.get_all_songs

    expect(result.length).to eq(1)
    expect(result.first.title).to eq("fake_title_1")
  end

end






