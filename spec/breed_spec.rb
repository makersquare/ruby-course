require_relative 'spec_helper.rb'

describe PAWS::Breed do
  it "creates a breed with price" do
    breed = PAWS::Breed.new("boxer")
    expect(breed).to be_a(PAWS::Breed)
  end

  it "can access all those variables" do
    breed = PAWS::Breed.new("boxer")
    expect(breed.breed).to eq("boxer")
    expect(breed.price).to eq(nil)
  end

  it "can change price" do
    breed = PAWS::Breed.new("boxer")
    breed.update_price(500)
    expect(breed.price).to eq(500)
  end

end