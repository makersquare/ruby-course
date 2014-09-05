require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Breeds do
  before(:each) {PuppyBreeder::Repos::Breeds.new.destroy}

  describe '.log' do
    it 'returns an array of breed objects' do
      breeds = PuppyBreeder::Repos::Breeds.new
      result = breeds.log

      expect(result).to eq ([])

      golden = PuppyBreeder::Breed.new("Golden Retriever", 800)
      breeds.add_breed(golden)
      result = breeds.log

      expect(result.size).to eq 1
      expect(result.first.class).to eq(PuppyBreeder::Breed)
    end 
  end
end