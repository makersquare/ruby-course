require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do

  describe '.initialize' do

    it 'sets the name, breed, and age' do
      puppy = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)
      expect(puppy.name).to eq("Bowser")
      expect(puppy.breed).to eq("golden retriever")
      expect(puppy.age).to eq(0.5)
    end

  end



end