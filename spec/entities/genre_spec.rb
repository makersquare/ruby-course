require_relative '../spec_helper.rb'

describe Songify::Genre do
  let(:genre) { Songify::Genre.new('Classic Rock') }

  it "Initializes the Genre class." do
    expect(genre.name).to eq('Classic Rock')
    expect(genre.id).to be_nil
  end
  
end