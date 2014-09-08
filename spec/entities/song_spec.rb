require_relative '../spec_helper.rb'

describe Songify::Song do 
  let(:song) { Songify::Song.new('When the Levee Breaks', 'Led Zeppelin', 'Led Zeppelin IV', 1971, 'Classic Rock') }

  # Initialize Method Tester
  it "Initializes the Song class with the instance variables: title, artist, album, and year." do

    expect(song.title).to eq('When the Levee Breaks')
    expect(song.artist).to eq('Led Zeppelin')
    expect(song.album).to eq('Led Zeppelin IV')
    expect(song.year).to eq(1971)
    expect(song.genre).to eq('Classic Rock')
    expect(song.rating).to be_nil
    expect(song.reviews.class).to eq(Array)

  end

  it "Update the year of the song" do

    song.year = 1990
    expect(song.year).to eq(1990)

    song.year = 1971
    expect(song.year).to eq(1971)

  end

end