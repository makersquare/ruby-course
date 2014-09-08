require_relative '../spec_helper.rb'


describe Songify::Repositories::Songs do
  Songify.song_repo.drop_table
  let(:songa){Songify::Song.new('artist','songname','albumA',4)}
  let(:songb){Songify::Song.new('artist','songname','albumA',5)}
  let(:songc){Songify::Song.new('artist','songname','albumA',6)}
  let(:songd){Songify::Song.new('artist','songname','albumD',7)}
  let(:songe){Songify::Song.new('artist','songname','albumE',8)}
  let(:songf){Songify::Song.new('artist','songname','albumF',9)}

  it 'Will SAVE a Song' do
    Songify.song_repo.save_a_song(songa)
    Songify.song_repo.save_a_song(songb)
    Songify.song_repo.save_a_song(songc)
    expect(songa).to be_a(Songify::Song)
    expect(Songify.song_repo.get_all_songs.entries.count).to eq (3)
  end

  it 'Will GET a Song' do
    song1 = Songify.song_repo.get_a_song(1)
    expect(song1.artist).to eq("artist")
    expect(song1.title).to eq("songname")
    expect(song1.album).to eq("albumA")
    expect(song1.length).to eq(4)
    expect(song1.id).to eq(1)
    expect(song1).to be_a(Songify::Song)
  end

  it 'Will GET all Songs' do
    Songify.song_repo.save_a_song(songd)
    Songify.song_repo.save_a_song(songe)
    Songify.song_repo.save_a_song(songf)
    expect(Songify.song_repo.get_all_songs.count).to eq(6)
  end

  it 'Will UPDATE a Song' do
    Songify.song_repo.update(6,'artist','artist10')#,song10,album10,10')
    song6 = Songify.song_repo.get_a_song(6)
    expect(song6.artist).to eq("artist10")
  end

  it 'Will update multipel attributes' do
    Songify.song_repo.update_all(6,nil,'song10','album10')#,10)
    song6 = Songify.song_repo.get_a_song(6)
    expect(song6.title).to eq("song10")
    expect(song6.album).to eq("album10")
    expect(song6.id).to eq(6)
  end

  it 'Will DESTROY a Song' do
    Songify.song_repo.delete_a_song(1)
    expect(Songify.song_repo.get_all_songs.entries.count).to eq(5)
  end



end