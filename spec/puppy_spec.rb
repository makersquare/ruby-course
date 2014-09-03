require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "creates a new puppy with name, breed and age" do
    result = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    expect(result.class).to eq(PuppyBreeder::Puppy)
  end

  it "checks name" do
    result = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    expect(result.name).to eq("molly")
  end

  it "checks breed" do
    result = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    expect(result.breed).to eq("german shepherd")
  end

  it "checks age" do
    result = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    expect(result.age).to eq(21)
  end
end