require 'spec_helper'

describe Songify::Genre do
    
  let(:genre) {Songify::Genre.new("rap")}
  
  it 'will initialize genre type' do
    expect(genre.genre).to eq("rap")
  end

end