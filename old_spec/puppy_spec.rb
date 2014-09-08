require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "creates an instance of the puppy class" do
    dana = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 4)

    expect(dana.class).to eq(PuppyBreeder::Puppy)
  end

  it "checks to make sure the variables are set" do
  dana = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 4)

  expect(dana.name).to eq("Dana")
  expect(dana.breed).to eq("Schnauzer")
  expect(dana.age).to eq(4)
  end    
end

