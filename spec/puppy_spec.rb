require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "allows the breeder to add puppies" do
    result = PuppyBreeder::Puppy.new("Spot", :chow, 1)

    expect(result.name).to eq ("Spot")
    expect(result.breed).to eq (:chow)
    expect(result.age).to eq 1
  end

  it "stores each puppy in a hash, sorted by breed" do 

    mill = PuppyBreeder::Breeder.new
    spot = PuppyBreeder::Puppy.new("Spot", :chow, 1)

    binding.pry
    expect(PuppyBreeder::Breeder.puppy_inventory.count).to eq 1
  end

end