require_relative '../spec_helper.rb'

describe Songify::Genre do 
  let(:genre) { Songify::Genre.new('Fake Genre') }
  
  it 'will initialize with a name' do
    song = Songify::Genre.new('Fake Genre')
    expect(genre.name).to eq('Fake Genre')
  end
end