require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::PuppyLog do
  describe '.add_puppy' do
    it 'adds a puppy to the data structure' do
      PuppyBreeder.puppy_repo.drop_tables
      puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
      puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
      puppy3 = PuppyBreeder::Puppy.new("Jill", "Husky", 50)

      PuppyBreeder.puppy_repo.add_puppy(puppy1)
      PuppyBreeder.puppy_repo.add_puppy(puppy2)
      PuppyBreeder.puppy_repo.add_puppy(puppy3)

      res = PuppyBreeder.puppy_repo.log.select { |x| x.name == "Fido" }.first.name
      expect(res).to eq(puppy1.name)
      result = PuppyBreeder.puppy_repo.log.size
      expect(result).to eq(3)
    end
  end
end