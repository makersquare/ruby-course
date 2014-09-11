require_relative '../spec_helper.rb'

describe Songify::Genre do 



  it 'will initialize with title attribute' do

    genre = Songify::Genre.new('death metal')

    expect(genre.title). to eq('death metal')

  end

end