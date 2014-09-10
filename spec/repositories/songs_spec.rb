require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  let(:songs) { Songify.songs }
  let(:song) { Songify::Song.new('When the Levee Breaks', 'Led Zeppelin', 'Led Zeppelin IV', 1971, 'Classic Rock') }
  let(:song2) { Songify::Song.new('Mr. Brightside', 'The Killers', 'Hot Fuss', 2003, 'Indie Rock') }
  let(:song3) { Songify::Song.new("Since Ive Been Loving You", 'Led Zeppelin', 'Led Zeppelin III', 1970, 'Classic Rock') }
  let(:song4) { Songify::Song.new('Daylight', 'Matt and Kim', 'Grand', 2009, 'Indie Pop') }

  it "Methods: save_song and get_all_songs. Saves a song. Then returns all songs." do

    songs.drop_and_rebuild_table

    expect(song.id).to be_nil

    songs.save_song(song)
    songs.save_song(song2)
    songs.save_song(song3)
    songs.save_song(song4)

    song_list = songs.get_all_songs

    expect(song.id).to_not be_nil
    expect(songs.class).to eq(Songify::Repositories::Songs)
    expect(song_list.class).to eq(Array)
    expect(song_list.length).to eq(4)

  end

  it "Returns the song that was requested by id" do

    songs.drop_and_rebuild_table

    songs.save_song(song)
    songs.save_song(song2)

    song_list = songs.get_all_songs

    levee = songs.get_a_song(song_list.first.id)
    brightside = songs.get_a_song(song_list[1].id)

    expect(levee.first["title"]).to eq('When the Levee Breaks')
    expect(brightside.first["year"]).to eq("2003")

  end

  it "Saves multiple song objects at once" do

    songs.drop_and_rebuild_table

    songs.save_multiple_songs(song, song2, song3, song4)

    song_list = songs.get_all_songs
    expect(song_list.size).to eq(4)

  end

  it "Deletes a song from the database" do

    songs.drop_and_rebuild_table

    songs.save_song(song)
    songs.save_song(song2)

    song_list = songs.get_all_songs
    expect(songs.get_all_songs.length).to eq(2)

    songs.delete_song(song_list.first.id)

    song_list = songs.get_all_songs
    expect(song_list.length).to eq(1)

    songs.delete_song(song_list.first.id)

    song_list = songs.get_all_songs
    expect(song_list.length).to eq(0)

    songs.drop_and_rebuild_table

  end
end