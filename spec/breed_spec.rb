require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do
  describe '.initialize' do
    it "creates a breed with a breed and a price" do
      golden = PuppyBreeder::Breed.new("Golden Retriever", 800)

      expect(golden.breed).to eq("Golden Retriever")
      expect(golden.price).to eq 800
    end
  end
end