require_relative '../spec_helper.rb'

describe Songify::Genre do
  let(:genre) { genre = Songify::Genre.new("rap") }
  
  it 'will initialize with a name' do
    expect(genre.name).to eq("rap")
  end
end