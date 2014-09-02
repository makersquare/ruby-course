require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do

  describe '.initialize' do

    it "creates a new breeder class" do

      breeder1 = PuppyBreeder::Breeder.new("Ravi")
    
      expect(breeder1.name).to eq("Ravi")
      

    end

    it "it makes a puppy be fore sale" do

    breeder1 = PuppyBreeder::Breeder.new("Ravi")
    
    expect(breeder1.name).to eq("Ravi")
    

    end



  end

end
