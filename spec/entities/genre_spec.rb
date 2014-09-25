require_relative '../spec_helper.rb'

describe Songify::Genre do

  it "creates a genre with an accessible name and nil id" do
    x = Songify::Genre.new(genre:"rock")
    expect(x).to be_a(Songify::Genre)
    expect(x.genre).to eq("Rock")
    expect(x.id).to eq(nil)
  end

end