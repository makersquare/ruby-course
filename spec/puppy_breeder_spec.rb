require_relative 'spec_helper.rb'

describe PuppyBreeder do
  describe '.add_puppy' do
    it 'creates a data structure (hash) which stores puppies by breed' do
      puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
      puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
      puppy3 = PuppyBreeder::Puppy.new("Jill", "Great Dane", 50)
      PuppyBreeder.add_puppy(puppy1)
      PuppyBreeder.add_puppy(puppy2)
      PuppyBreeder.add_puppy(puppy3)

      expect(PuppyBreeder.get_puppies).to be_a(Hash)
    end
  end
end