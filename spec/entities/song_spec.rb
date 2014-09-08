require_relative "../spec_helper.rb"

describe Songify::Song do 
  let(:tune) {Songify::Song.new("fake_title", "fake_artist", "fake_genre")}

  it "will initialize with song title, artist and genre" do


    expect(tune.title).to eq("fake_title")
    expect(tune.artist).to eq("fake_artist")
    expect(tune.genre).to eq("fake_genre")
  end
  
end