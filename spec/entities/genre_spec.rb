require_relative '../spec_helper.rb'

describe Songify::Genre do 



  it 'will initialize with title attribute and nil id' do

    genre = Songify::Genre.new('death metal')

    expect(genre.title). to eq('death metal')
    expect(genre.id). to eq(nil)
  end

end