require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyManager do

  describe '.add_puppy_for_sale' do

    it 'pushes the given puppy argument into the PuppyManager @@puppies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale.include?(puppy)).to eq(true)
    end


  end

end