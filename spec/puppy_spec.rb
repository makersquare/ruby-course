require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do

    it "initialize the puppy object" do

      puppy1 = PuppyBreeder::Puppy.new("Fido", 23, "pitbull")
    
      expect(puppy1.name).to eq("Fido")
      expect(puppy1.age).to eq(23)
      expect(puppy1.breed).to eq("pitbull")

    end

end