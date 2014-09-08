require_relative "../spec_helper.rb"

describe Songify::Repo::Songs do  
  before(:each) { Songify.songs_repo.drop_table }

  let(:songs_test) {Songify.songs_repo}
  let(:tune1) {Songify::Song.new("fake_title", "fake_artist", "fake_genre")}
  let(:tune2) {Songify::Song.new("fake_2", "2_artist", "2_genre")}

  it "saves a Song to the database" do

    songs_test.save_song(tune1)
    result = songs_test.log

    expect(result.first.id).not_to be_nil

  end

  it "gets a Song from the database" do
    songs_test.save_song(tune1)
    songs_test.save_song(tune2)

    result = songs_test.get_song(tune1.id)

    expect(result.first.title).to eq("fake_title") 

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

    songs_test.delete_song(tune2.id)
    
    result = songs_test.get_all_songs

    expect(result.count).to eq 1
    expect(result.first.title).to eq "fake_title"
  end
  
end

