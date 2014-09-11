require_relative '../spec_helper.rb'

describe Songify::Genre do
  let(:genre) { Songify::Genre.new('fake_genre') }

  it 'will create a new genre' do
    expect(genre.name).to eq('fake_genre')
  end
end