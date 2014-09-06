require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Breeds do
  before(:each) {PuppyBreeder.breed_repo.destroy_and_rebuild}

  describe '.log' do
    it 'returns an array of breed objects' do
      breeds = PuppyBreeder.breed_repo
      result = breeds.log

      expect(result).to eq ([])

      golden = PuppyBreeder::Breed.new("Golden Retriever", 800)
      breeds.add_breed(golden)
      result = breeds.log

      expect(result.size).to eq 1
      expect(result.first.class).to eq(PuppyBreeder::Breed)
    end 
  end

  describe '.add_breed' do
    it 'adds a breed into the database' do
      golden = PuppyBreeder::Breed.new("Golden Retriever", 800)
      pitbull = PuppyBreeder::Breed.new("Pitbull", 500)
      breeds = PuppyBreeder.breed_repo
      breeds.add_breed(golden)
      result = breeds.log

      expect(result.size).to eq 1
      expect(result.first.price).to eq "$800.00"
      expect(result.first.breed).to eq "Golden Retriever"

      breeds.add_breed(pitbull)
      result = breeds.log

      expect(result.size).to eq 2
      expect(result.last.price).to eq "$500.00"
      expect(result.last.breed).to eq "Pitbull"
    end
  end
  
end