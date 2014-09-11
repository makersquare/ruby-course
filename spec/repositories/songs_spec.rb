require_relative "../spec_helper.rb"

describe Songify::Repo::Songs do  
  before(:each) { Songify.songs_repo.drop_table }

  let(:songs_test) {Songify.songs_repo}
  let(:tune1) {Songify::Song.new("fake_title", "fake_artist", "fake_album")}
  let(:tune2) {Songify::Song.new("fake_2", "2_artist", "2_album")}

  it "saves a Song to the database" do

    #added after Nick's example solution
    expect(tune1.id).to be_nil
   
    result = songs_test.save_song(tune1)

    expect(tune1.id).not_to be_nil

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


  
end

