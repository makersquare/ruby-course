require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  
  describe '.initialize' do
    it "creates a puppy with a name, age, breed, price set to nil, and availability set to for_sale" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")

      expect(spot.name).to eq("Spot")
      expect(spot.age).to eq 1
      expect(spot.breed).to eq("Golden Retriever")
      expect(spot.price).to be_nil
      expect(spot.availability).to eq :for_sale
    end
  end

  describe '.sold!' do
    it 'changes the availability to :sold' do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      spot.sold!

      expect(spot.availability).to eq(:sold)
    end
  end

end