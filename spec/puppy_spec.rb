require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  describe '#initialize' do
    it 'initializes a puppy with a name, breed, and age (days old)' do
      puppy = PuppyBreeder::Puppy.new("Fido", "Husky", 30)

      expect(puppy.name).to eq("Fido")
      expect(puppy.breed).to eq("Husky")
      expect(puppy.age).to eq(30)
    end
  end
end