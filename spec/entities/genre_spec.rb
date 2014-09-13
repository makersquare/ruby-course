require_relative '../spec_helper.rb'

describe Songify::Genre do 
  let(:genre) { Songify::Genre.new('Whale Music')}

  it 'will initialize with 1 attribute' do 
    expect(genre.genre).to eq('Whale Music')
  end
end