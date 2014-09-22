require_relative "../spec_helper.rb"

describe Songify::Song do 
  let(:tune) {Songify::Song.new("fake_title", "fake_artist", "fake_album")}

  it "will initialize with song title, artist and album" do


    expect(tune.title).to eq("fake_title")
    expect(tune.artist).to eq("fake_artist")
    expect(tune.album).to eq("fake_album")
    expect(tune.genre_id).to eq(nil)
  end

  it "will set a genre id" do
    pop = Songify::Genre.new("pop")
    Songify.genres_repo.save_genre(pop)

   id = pop.id

    tune.set_genre_id(pop)
    expect(pop.id).not_to be_nil
    expect(tune.genre_id).to eq (id)
    
  end

  
end