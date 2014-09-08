require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do 

  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album') }


  before do
    Songify.songs_repo.drop_table
  end

  it 'saves a song' do
    #song created at top
    expect(song.id).to be(nil)

    Songify.songs_repo.save_a_song(song)

    expect(song.id).to_not be(nil)
  end

  it 'gets a song' do 
    Songify.songs_repo.save_a_song(song)
    song_id = song.id
    retrieved_song = Songify.songs_repo.get_a_song(song_id)

    expect(retrieved_song.first.id).to eq(song.id)
  end

  it 'gets all songs' do 
    song2 = Songify::Song.new("party time", "Bob", "Bob's hits")
    song3 = Songify::Song.new("party time", "Bob", "Bob's hits")
    Songify.songs_repo.save_a_song(song, song2, song3)

    expect(Songify.songs_repo.get_all_songs.length).to eq(3)
  end

  it 'deletes a song' do 
    song2 = Songify::Song.new("party time", "Bob", "Bob's hits")
    song3 = Songify::Song.new("party time", "Bob", "Bob's hits")
    Songify.songs_repo.save_a_song(song, song2, song3)
    Songify.songs_repo.delete_a_song(song3.id)

    expect(Songify.songs_repo.get_all_songs.length).to eq(2)
  end


end