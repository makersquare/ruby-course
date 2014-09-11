require_relative '../spec_helper.rb'

describe Songify::Genre do
  let(:genre) { Songify::Genre.new('pop')}
  
  describe '.initialize' do
    it 'will initialize with genre name and id set to nil' do
      expect(genre.genre_name).to eq 'pop'
      expect(genre.genre_id).to be_nil
    end
  end

end