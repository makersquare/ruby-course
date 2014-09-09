require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do

  let(:song) { Songify::Song.new("Dark Horse", "Katy Perry", "Prism") }
  let(:song2) { Songify::Song.new("Cry Me A River", "Justin Timberlake", "Justified") }

  before(:all) do
    Songify::Repos.instance_variable_set(:@db, PG.connect(host: 'localhost', dbname: 'songify-test'))
  end

  before(:each) do
    Songify::Repos.drop_tables
    Songify::Repos.create_tables

    Songify.songsrepo.add(song)
    Songify.songsrepo.add(song2)
  end

  describe "#add" do
    it "adds song to songs repo and sets song_id" do
      expect(song.song_id).to eq(1)
    end
  end

  describe "#get" do
    it "returns a specific song" do
      result = Songify.songsrepo.get(song)
      expect(result).to be_a(Songify::Song)
      expect(result.song_name).to eq("Dark Horse")
    end
  end

  describe "#get_all" do
    it "returns all songs" do
      result = Songify.songsrepo.get_all

      expect(result).to be_an(Array)
      expect(result.length).to eq(2)

      expect(result[0].artist).to eq("Katy Perry")
      expect(result[1].song_name).to eq("Cry Me A River")
      
    end
  end  

  describe "#delete" do
    it "deletes a song" do
      result = Songify.songsrepo.get_all

      expect(result.length).to eq(2)

      Songify.songsrepo.delete(song2)

      result2 = Songify.songsrepo.get_all

      expect(result2.length).to eq(1)
    end
  end

end
