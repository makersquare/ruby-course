require_relative '../spec_helper.rb'


describe Songify::Repositories::Genres do
  # Songify.genre_repo.drop_table
  let(:genrea){Songify::Genre.new('Country')}
  let(:genreb){Songify::Genre.new('Rap')}
  let(:genrec){Songify::Genre.new('Alternative')}
  let(:genred){Songify::Genre.new('Polka')}
  let(:genred){Songify::Genre.new('Polka')}



  it 'Will SAVE a Genre' do
    Songify.genre_repo.save_genre(genrea)
    Songify.genre_repo.save_genre(genreb)
    Songify.genre_repo.save_genre(genrec)
    expect(genrea).to be_a(Songify::Genre)
    expect(Songify.genre_repo.get_all_genres.entries.count).to eq (3)
  end

  it 'Will GET a Genre' do
    genre1 = Songify.genre_repo.get_a_genre(1)
    expect(genre1.genre).to eq("Country")
    expect(genre1.id).to eq(1)
    expect(genre1).to be_a(Songify::Genre)
    genre1 = Songify.genre_repo.get_a_genre(2)
    expect(genre1.genre).to eq("Rap")
    expect(genre1.id).to eq(2)
    expect(genre1).to be_a(Songify::Genre)
  end

  it 'Will GET all Genres' do
    expect(Songify.genre_repo.get_all_genres.count).to eq(3)
  end

  it 'Will UPDATE a Genre' do
    Songify.genre_repo.update(3,'new_name')
    genree = Songify.genre_repo.get_a_genre(3)
    expect(genree.genre).to eq("new_name")
  end

  it 'Will DESTROY a Song' do
    Songify.genre_repo.delete_a_genre(4)
    expect(Songify.genre_repo.get_all_genres.entries.count).to eq(3)
  end

end