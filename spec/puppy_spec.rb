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
    mill.add_inventory(spot)
  

    expect(mill.puppy_inventory.count).to eq 1
  end

  it "enables Breeder to add more than one puppy of the same breed" do
    mill = PuppyBreeder::Breeder.new
    pup1 = PuppyBreeder::Puppy.new("Spot", :chow, 1)
    pup2 = PuppyBreeder::Puppy.new("Josh", :chow, 2)
    mill.add_inventory(pup1)
    mill.add_inventory(pup2)

    expect(mill.puppy_inventory[:chow].count).to eq 2
  end

  it "Allows breeder to set price of puppy" do
    mill = PuppyBreeder::Breeder.new
    pup1 = PuppyBreeder::Puppy.new("Spot", :chow, 1)
    PuppyBreeder::Puppy.set_breed_price(:chow, 15)
    result = PuppyBreeder::Puppy.costs

    expect(result.count).to be 1
  end
end


