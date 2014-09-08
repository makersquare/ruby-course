require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do 
  let(:dj_fake) { Songify::Song.new("fake_title", "fake_artist", "fake_album")}
  before(:each) { Songify.songs_repo.save_song(dj_fake) }
  after(:each) { Songify.songs_repo.truncate_songs}
  
  it "should add song to db" do 

    expect(dj_fake.id).should_not eq(nil)
    
  end
  
  it 'get all the songs' do 
    x = Songify.songs_repo.get_all_songs

    expect(x.length).to eq(1)
  end


end

expect(result).to be_a(Songify::Song)