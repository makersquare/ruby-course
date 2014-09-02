require_relative 'spec_helper.rb'

describe PuppyBreeder::ForSale do
  it "keeps track of all puppies currently for sale" do
    spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
    fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
    
    result = spot.add

    expect(result.size).to eq 1
    expect(result[spot.breed][:count]).to eq 1
    expect(result[spot.breed][:price]).to be_nil

    result2 = fido.add(800)
    binding.pry

    expect(result.size).to eq 2
    expect(result[fido.breed][:count]).to eq 1
    expect(result[fido.breed][:price]).to eq 800
  end
end