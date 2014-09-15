require_relative "../spec_helper.rb"

describe Songify::Repo::Songs do  
  before(:each) do
   Songify.songs_repo.drop_table
   Songify.genres_repo.drop_table
   Songify.genres_repo.build_table
   Songify.songs_repo.build_table
  end

  let(:songs_test) {Songify.songs_repo}
  let(:tune1) {Songify::Song.new("fake_title", "fake_artist", "fake_album", )}
  let(:tune2) {Songify::Song.new("fake_2", "2_artist", "2_album")}

  it "saves a Song to the database" do

    #added after Nick's example solution
    expect(tune1.id).to be_nil
   
    result = songs_test.save_song(tune1)

    expect(tune1.id).not_to be_nil

  end

  it "saves a Song to the database with genre id foreign key" do
    rock = Songify::Genre.new("rock")
    Songify.genres_repo.save_genre(rock)

    

    tune1.set_genre_id(rock)
    songs_test.save_song(tune1)
    
    expect(rock.id).not_to be_nil
    expect(tune1.genre_id).not_to be_nil
    expect(tune1.genre_id).to eq (rock.id)
  end

  it "gets a Song from the database by ID" do
    songs_test.save_song(tune1)
    songs_test.save_song(tune2)

    result = songs_test.get_song(tune1.id)

    expect(result.title).to eq("fake_title") 
    expect(result).to be_a(Songify::Song)
  end

  it "gets all Songs from the database" do
    songs_test.save_song(tune1)
    songs_test.save_song(tune2)

    result = songs_test.get_all_songs

    expect(result.first.title).to eq("fake_title")
    expect(result.last.artist).to eq("2_artist")

  end

  it "deletes a Song from the database" do 
    songs_test.save_song(tune1)
    songs_test.save_song(tune2)
    result = songs_test.get_all_songs

    expect(result.count).to eq 2

    songs_test.delete_song(tune2.id)
    
    result = songs_test.get_all_songs

    expect(result.count).to eq 1
    expect(result.first.title).to eq "fake_title"
  end

  

  it "selects Songs from the database by genre" do
    hard_rock = Songify::Genre.new("hard rock")
    Songify.genres_repo.save_genre(hard_rock)
    tune1.set_genre_id(hard_rock)
    tune2.set_genre_id(Songify::Genre.new("easy listening"))
    songs_test.save_song(tune1)
    songs_test.save_song(tune2)

    result = songs_test.select_song_by_genre(hard_rock)

    expect(result.first.genre_id).to eq (1)
    expect(result.first.title).to eq ("fake_title")

  end

  
end

