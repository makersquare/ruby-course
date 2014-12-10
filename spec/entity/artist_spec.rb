require_relative '../../spec_helper.rb'

describe 'the artist class' do 

  before(:each) do
    @artist = Songify::Artist.new({name: 'Seal'})
  end

  it 'should have a name' do
    expect(@artist.name).to eq('Seal')
  end

end