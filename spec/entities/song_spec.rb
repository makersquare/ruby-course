require_relative '../spec_helper.rb'

describe Songify::Song do

  describe "initialize" do
    it "initializes with song name, artist(s), album" do
      song = Songify::Song.new("Dark Horse", "Katy Perry", "Prism")

      expect(song.song_name).to eq("Dark Horse")
      expect(song.artist).to eq("Katy Perry")
      expect(song.album).to eq("Prism")
    end
  end

end