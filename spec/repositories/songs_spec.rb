require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do 
  it "adds a song" do
    song_object = Songify::Song.new("Fake Title", "Fake Artist", "Fake Album")
    Songify.songs_repo.save_a_song(song_object)
    expect(song_object.id).should_not be_nil
  end

  it "saves a song" do
    song_object = Songify::Song.new("Fake Title", "Fake Artist", "Fake Album")
    y = Songify.songs_repo.save_a_song(song_object)
    expect(y.length).to eq(1)
  end

  it "deletes a song" do 
    Songify.songs_repo.drop_table
    song_object = Songify::Song.new("Fake Title", "Fake Artist", "Fake Album")
    song_object1 = Songify::Song.new("Fake Title1", "Fake Artist1", "Fake Album1")
    Songify.songs_repo.save_a_song(song_object)
    Songify.songs_repo.save_a_song(song_object1)
    y = Songify.songs_repo.get_all_songs
    expect(y.length).to eq(2)
    Songify.songs_repo.delete_a_song(song_object1.id)
    y = Songify.songs_repo.get_all_songs
    expect(y.length).to eq(1)
  end

  it "gets a song" do
    song_object = Songify::Song.new("Fake Title", "Fake Artist", "Fake Album")
    song_object1 = Songify::Song.new("Fake Title1", "Fake Artist1", "Fake Album1")
    Songify.songs_repo.save_a_song(song_object)

    y = Songify.songs_repo.get_a_song(song_object.id)

    expect(y.id).to_not be_nil
  end

  it "gets all songs" do
    Songify.songs_repo.drop_table

    song_object = Songify::Song.new("Fake Title", "Fake Artist", "Fake Album")
    song_object1 = Songify::Song.new("Fake Title1", "Fake Artist1", "Fake Album1")
    song_object2 = Songify::Song.new("Fake Title2", "2Fake Artist", "2Fake Album")
    Songify.songs_repo.save_a_song(song_object)
    Songify.songs_repo.save_a_song(song_object1)
    Songify.songs_repo.save_a_song(song_object2)

    y = Songify.songs_repo.get_all_songs
    expect(y.length).to eq(3)
  end
end