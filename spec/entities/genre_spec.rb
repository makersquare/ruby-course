require_relative '../spec_helper.rb'

describe Songify::Genre do 
  let(:genre){Songify::Genre.new('hip-hop')}

  it 'Will initialize genre with title' do
    expect(genre.genre).to eq('hip-hop')
  end
end

