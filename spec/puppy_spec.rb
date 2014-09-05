require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do

  before(:each) { PuppyBreeder::Puppy.class_variable_set(
    :@@counter, 0)}

# Initialize Method Test
  it "Creates an instance of Puppy Class. Creates instance variables for breed, cost, sold_status, and puppy_id." do

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)

    expect(puppy.breed).to eq("French Bulldog")
    expect(puppy.name).to eq("Murphy")
    expect(puppy.age).to eq(3)
    expect(puppy.status).to eq("Available")
    expect(puppy.id).to eq(nil)
    expect(puppy.class).to eq(PuppyBreeder::Puppy)

    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Sadie", 1)

    expect(puppy2.breed).to eq("Boxer")
    expect(puppy2.name).to eq("Sadie")
    expect(puppy2.age).to eq(1)
    expect(puppy2.status).to eq("Available")
    expect(puppy2.id).to eq(nil)
    expect(puppy2.class).to eq(PuppyBreeder::Puppy)

  end

# Available Method Test
  it "Tests available? and available! methods." do

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3, "On Hold")

    expect(puppy.available?).to be_false
    expect(puppy.status).to eq("On Hold")
    puppy.available!
    expect(puppy.available?).to be_true
    expect(puppy.status).to eq("Available")

  end

# On Hold Method Test
  it "Changes the puppy's status to On Hold" do

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)

    expect(puppy.on_hold?).to be_false
    expect(puppy.status).to eq("Available")
    puppy.on_hold!
    expect(puppy.on_hold?).to be_true
    expect(puppy.status).to eq("On Hold")

  end

# Sold Method Test
  it "Changes the puppy's status to Sold" do

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)

    expect(puppy.sold?).to be_false
    expect(puppy.status).to eq("Available")
    puppy.sold!
    expect(puppy.sold?).to be_true
    expect(puppy.status).to eq("Sold")

  end

end