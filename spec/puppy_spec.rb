require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "Creates an instance of Puppy Class. Creates instance variables for breed, cost, sold_status, and puppy_id." do

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 0.5)

    expect(puppy.breed).to eq("French Bulldog")
    expect(puppy.name).to eq("Murphy")
    expect(puppy.age).to eq(0.5)
    expect(puppy.cost).to eq(1500)
    expect(puppy.sold_status).to eq("Available")
    expect(puppy.puppy_id).to eq(1)
    expect(puppy.class).to eq(PuppyBreeder::Puppy)

    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Sadie", 1)

    expect(puppy2.breed).to eq("Boxer")
    expect(puppy2.name).to eq("Sadie")
    expect(puppy2.age).to eq(1)
    expect(puppy2.cost).to eq(750)
    expect(puppy2.sold_status).to eq("Available")
    expect(puppy2.puppy_id).to eq(2)
    expect(puppy2.class).to eq(PuppyBreeder::Puppy)

  end

end