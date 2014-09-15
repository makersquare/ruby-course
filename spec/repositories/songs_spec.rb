require 'spec_helper.rb'

describe Songify::Repositories::Songs do

  before(:each) do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.build_table
    Songify.songs_repo.build_table

  end

  it 'will add genre id to song in songs table' do 
    song = Songify::Song.new("Rock Title", "Rock Artist", "Rock Album")
    genre = Songify::Genre.new("rock")
    Songify.genres_repo.save_genre(genre)
    Songify.songs_repo.save_a_song(song, genre)

    song_list = Songify.songs_repo.get_all_songs

    expect(song_list.size).to eq(1)

  end

  it 'will save a song' do
    song = Songify::Song.new("Rock Title", "Rock Artist", "Rock Album")
    genre = Songify::Genre.new("rock")
    Songify.genres_repo.save_genre(genre)

    expect(song.id).to be_nil
    
    Songify.songs_repo.save_a_song(song, genre)

    expect(song.id).to_not be_nil
  end 

  it 'will get a song by id' do
    song = Songify::Song.new("Rock Title", "Rock Artist", "Rock Album")
    genre = Songify::Genre.new("rock")
    Songify.genres_repo.save_genre(genre)
    Songify.songs_repo.save_a_song(song, genre)

    result = Songify.songs_repo.get_a_song(song.id)

    expect(result).to be_a(Songify::Song)
    expect(result.id).to eq(song.id)
  end

  it 'will get all songs' do
    genre1 = Songify::Genre.new("rock")
    genre2 = Songify::Genre.new("rap")
    Songify.genres_repo.save_genre(genre1)
    Songify.genres_repo.save_genre(genre2)


    song1 = Songify::Song.new("rock_title", "rock_artist", "rock_album")
    song2 = Songify::Song.new("rap_title_2", "rap_artist_2", "rap_album_2")
    Songify.songs_repo.save_a_song(song1, genre1)
    Songify.songs_repo.save_a_song(song2, genre2)

    song_list = Songify.songs_repo.get_all_songs

    expect(song_list.size).to eq(2)
  end


  it 'will delete a song by id' do
    genre1 = Songify::Genre.new("rock")
    genre2 = Songify::Genre.new("rap")
    Songify.genres_repo.save_genre(genre1)

    song1 = Songify::Song.new("rock_title", "rock_artist", "rock_album")
    song2 = Songify::Song.new("rap_title_2", "rap_artist_2", "rap_album_2")
    Songify.songs_repo.save_a_song(song1, genre1)
    Songify.songs_repo.save_a_song(song2, genre2)

    song_list = Songify.songs_repo.get_all_songs

    expect(song_list.size).to eq(2)

    Songify.songs_repo.delete_a_song(song2.id)

    song_list = Songify.songs_repo.get_all_songs

    expect(song_list.size).to eq(1)
    expect(song_list.first.title).to eq("rock_title")
  end
end





