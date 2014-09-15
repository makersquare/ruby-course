require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do 

  let(:song) { Songify::Song.new('fake_title', 'fake_artist', 'fake_album', 1) }


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
    song2 = Songify::Song.new("party time", "Bob", "Bob's hits", 1)
    song3 = Songify::Song.new("party time1", "Bob", "Bob's hits", 1)
    Songify.songs_repo.save_a_song(song, song2, song3)

    expect(Songify.songs_repo.get_all_songs.length).to eq(3)
  end

  it 'deletes a song' do 
    song2 = Songify::Song.new("party time", "Bob", "Bob's hits", 1)
    song3 = Songify::Song.new("party time1", "Bob", "Bob's hits", 1)
    Songify.songs_repo.save_a_song(song, song2, song3)
    Songify.songs_repo.delete_a_song(song3.id)
    #this block in expect should be written up here and stored in a variable
    #which is then passed in the ()
    expect(Songify.songs_repo.get_all_songs.length).to eq(2)
  end
end

 # it 'prevents duplicates from being added to the database' do 
 #    song2 = Songify::Song.new("party time", "Bob", "Bob's hits")
 #    song3 = Songify::Song.new("party time", "Bob", "Bob's hits")

 #    expect(Songify.songs_repo.save_a_song(song, song2, song3)).to eq("duplicate")
 #  end
# def save_a_song(*song)
#          songs = get_all_songs
#          duplicates = []
#          songs.each do |song|
#            result = @db.exec(%q[
#              SELECT * FROM songs
#              WHERE artist = 'song.artist' AND title = 'song.title'
#              AND album = 'song.album'
#              ])
#            duplicates.push(result.entries)
#          end

#          if duplicates.length > 0
#            return "duplicate"
#          else
#           song.each do |song|
#            result = @db.exec(%q[
#               INSERT INTO songs (title, artist, album)
#               VALUES ($1, $2, $3)
#               RETURNING id;
#               ], [song.title, song.artist, song.album])
#             song.instance_variable_set :@id, result.entries.first["id"].to_i 
#           end
#          end
      
#       end