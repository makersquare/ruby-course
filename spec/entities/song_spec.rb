require_relative '../spec_helper.rb'

describe Songify::Song do

  # before(:all) do
  #   @test_song = Songify::Song.new(title: "Radio Radio",artist: "Elvis Costello",album: "This Year's Model",year_published: 1978)
  # end

let(:test_song) {Songify::Song.new(title: "Radio Radio",artist: "Elvis Costello",album: "This Year's Model",year_published: 1978)}

  it "creates a song" do
    expect(test_song).to be_a(Songify::Song)
  end

  it "creates a song with title,artist,album,year_published" do
    expect(test_song.artist).to eq("Elvis Costello")
    expect(test_song.title).to eq("Radio Radio")
    expect(test_song.year_published).to eq(1978)
    expect(test_song.album).to eq("This Year's Model")
    expect(test_song.rating).to eq(nil)
  end

  it "can rate a song" do
    test_song.rate 1
    expect(test_song.rating).to eq(1)
  end

  it "can correct info" do
    test_song.correct_info("rating",5)
    expect(test_song.rating).to eq(5)
  end


end