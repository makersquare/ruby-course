require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyContainer do
  describe '.add_puppy' do
    it 'adds a puppy to the data structure' do
      puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
      puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
      puppy3 = PuppyBreeder::Puppy.new("Jill", "Great Dane", 50)
      PuppyBreeder::PuppyContainer.add_puppy(puppy1)
      PuppyBreeder::PuppyContainer.add_puppy(puppy2)
      PuppyBreeder::PuppyContainer.add_puppy(puppy3)

      res = PuppyBreeder::PuppyContainer.get_puppies["Greyhound"][:list]

      expect(res).to include(puppy1)
    end
  end

  describe '.add_breed' do
    it 'adds a breed and price to the hash' do
      PuppyBreeder::PuppyContainer.add_breed("Husky")
      puppy = PuppyBreeder::Puppy.new("Jack", "Husky", 25)
      PuppyBreeder::PuppyContainer.add_puppy(puppy)
      res = PuppyBreeder::PuppyContainer.get_puppies["Husky"][:list]
      expect(res).to include(puppy)
    end
  end
end