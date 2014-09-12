require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
let (:subject) { Songify::Repos::Songs.new('songify_test') }
let (:subgenre) { Songify::Repos::Genres.new('songify_test') }

let(:test_song1) {Songify::Song.new(title: "Radio Radio",artist: "Elvis Costello",album: "This Year's Model",year_published: 1978, genre: "punk rock")}
let(:test_song2) {Songify::Song.new(title: "Goin' Out West",artist: "Tom Waits",album: "Bone Machine",year_published: 1992, genre:"weird")}

  before(:each) do
    subject.drop_table
  end

  after do
    subject.drop_table
  end

  # after(:all) do
  #   subject.drop_table
  #   subgenre.drop_table
  # end

  it "saves a song" do
    subject.save_a_song(test_song1)
    test_answer = subject.get_all_songs

    expect(test_song1.artist).to eq(test_answer.first.artist)
  end

  it "gets a song by id" do
    subject.save_a_song(test_song1)
    result = subject.get_a_song(test_song1.id)

    expect(result.artist).to eq("Elvis Costello")
    expect(result.title).to eq("Radio Radio")
    expect(result.year_published).to eq(1978)
    expect(result.album).to eq("This Year's Model")
    expect(result.rating).to eq(nil)
    expect(result.id).to eq(test_song1.id)
  end

  it "gets all songs" do
    subject.save_a_song(test_song1)
    subject.save_a_song(test_song2)
    test_answer = subject.get_all_songs

    expect(test_song1.artist).to eq(test_answer.first.artist)
    expect(test_song2.artist).to eq(test_answer.last.artist)
  end

  it "deletes a song" do
    subject.save_a_song(test_song1)
    subject.save_a_song(test_song2)
    result = subject.delete_a_song(test_song1.id)

    expect(result.artist).to eq("Elvis Costello")
    expect(result.title).to eq("Radio Radio")
    expect(result.year_published).to eq(1978)
    expect(result.album).to eq("This Year's Model")
    expect(result.rating).to eq(nil)
    expect(result.id).to eq(test_song1.id)

    test_answer = subject.get_all_songs
    expect(test_answer.count).to eq(1)
    expect(test_song2.artist).to eq(test_answer.first.artist)
  end

  it "can get all the songs by album or by artist" do
    subject.save_a_song(test_song1)
    subject.save_a_song(test_song2)
    subject.save_a_song(Songify::Song.new(title: "Accidents Will Happen",artist: "Elvis Costello",album: "Armed Forces",year_published: 1979, genre: "punk rock"))
    test_answer = subject.get_all_songs
    expect(test_answer.count).to eq(3)
    test_answer2 = subject.get_all_songs_by(artist:"Elvis Costello")
    expect(test_answer2.count).to eq(2)
    test_answer3 = subject.get_all_songs_by(album:"Armed Forces")
    expect(test_answer3.count).to eq(1)
    expect(test_answer3.first.artist).to eq("Elvis Costello")
  end

end