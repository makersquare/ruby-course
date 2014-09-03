require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  describe '.initialize' do
    it "creates a puppy with a name, age and breed" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")

      expect(spot.name).to eq("Spot")
      expect(spot.age).to eq 1
      expect(spot.breed).to eq("Golden Retriever")
      expect(spot.status).to eq(:not_for_sale)
    end
  end

  describe '.add' do
    it 'changes the status to :for_sale' do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      spot.add

      expect(spot.status).to eq(:for_sale)
    end
  end

end