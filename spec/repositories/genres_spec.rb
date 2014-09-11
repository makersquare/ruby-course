require_relative '../spec_helper.rb'


describe Songify::Repositories::Genres do
  Songify.genre_repo.drop_table
  let(:genrea){Songify::Genre.new('Country')}
  let(:genreb){Songify::Genre.new('Rap')}
  let(:genrec){Songify::Genre.new('Alternative')}

  it 'Will SAVE a Genre' do
    Songify.genre_repo.save_genre(genrea)
    Songify.genre_repo.save_genre(genreb)
    Songify.genre_repo.save_genre(genrec)
    expect(genrea).to be_a(Songify::Genre)
    expect(Songify.genre_repo.get_all_genres.entries.count).to eq (3)
  end

  xit 'Will GET a Song' do
    genre1 = Songify.genre_repo.get_a_genre(1)
    expect(song1.genre).to eq("Country")
    # expect(song1.length).to eq(4)
    # expect(song1.id).to eq(1)
    expect(song1).to be_a(Songify::Genre)
  end

  xit 'Will GET all Songs' do
    Songify.genre_repo.save_a_song(songd)
    Songify.genre_repo.save_a_song(songe)
    Songify.genre_repo.save_a_song(songf)
    expect(Songify.genre_repo.get_all_songs.count).to eq(6)
  end

  xit 'Will UPDATE a Song' do
    Songify.genre_repo.update(6,'artist','artist10')#,song10,album10,10')
    song6 = Songify.genre_repo.get_a_song(6)
    expect(song6.artist).to eq("artist10")
  end

  xit 'Will update multipel attributes' do
    Songify.genre_repo.update_all(6,nil,'song10','album10')#,10)
    song6 = Songify.genre_repo.get_a_song(6)
    expect(song6.title).to eq("song10")
    expect(song6.album).to eq("album10")
    expect(song6.id).to eq(6)
  end

  xit 'Will DESTROY a Song' do
    Songify.genre_repo.delete_a_song(1)
    expect(Songify.genre_repo.get_all_songs.entries.count).to eq(5)
  end

end