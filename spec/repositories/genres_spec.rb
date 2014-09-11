require_relative '../spec_helper.rb'
require 'pry-byebug'

describe Songify::Repositories::Genres do
  let(:genre) { Songify::Genre.new('fake_genre') }
  let(:genre1) { Songify::Genre.new('fake_genre_1') }

  before(:each) do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.build_table
    Songify.songs_repo.build_table
  end

  it 'adds a genre to the table' do
    expect(genre.id).to be_nil
    Songify.genres_repo.save_genre(genre)
    expect(genre.id).to_not be_nil
  end
end