require_relative '../spec_helper.rb'
require_relative '../spec_helper.rb'

describe Songify::Song do 
  let(:dj_fake) { Songify::Song.new("fake_title", "fake_artist", "fake_album")}
  it 'will initialize with 3 attr' do 
    #dj_fake = Songify::Song.new("fake_title", "fake_artist", "fake_album")

    expect(dj_fake.title).to eq("fake_title")
    expect(dj_fake.artist).to eq("fake_artist")
    expect(dj_fake.album).to eq("fake_album")
  end


end