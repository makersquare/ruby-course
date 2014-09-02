require_relative 'spec_helper.rb'

describe PuppyBreeder::ForSale do
  xit "keeps track of all puppies currently for sale" do
    spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
    fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
    spot.for_sale

    expect(array.size).to eq 1
  end
end