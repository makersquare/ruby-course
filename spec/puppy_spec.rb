require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "initializes with name, breed and age" do

    puppy = PuppyBreeder::Puppy.new("mav", "husky", 4)
    expect(puppy.name).to eq ("mav")
    expect(puppy.breed).to eq("husky")
    expect(puppy.age).to eq(4)
  end

end