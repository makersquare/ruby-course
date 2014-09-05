require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::PuppyRepo do

# Initialize Method Tester
  it "Creates a container for all puppies the breeder has." do

    # Previous tests:
    # breeder = PuppyBreeder::Repos::PuppyContainer.new
    
    # expect(breeder.class).to eq(PuppyBreeder::PuppyContainer)
    # expect(breeder.puppies.class).to eq(Hash)

    # New tests for database:
    breeder = PuppyBreeder::Repos::PuppyRepo.new

    expect(breeder.class).to eq(PuppyBreeder::Repos::PuppyRepo)
    expect(breeder.log.class).to eq(Array)

  end

# Add Breed Method Tester
  xit "Adds breeds to the container. Associates a cost with breed, and creates a available puppies array." do

    # Previous tests:
    # breeder = PuppyBreeder::PuppyContainer.new
    
    # breeder.add_breed("French Bulldog", 1500)
    # breeder.add_breed("Shih Tzu", 500)
    # breeder.add_breed("Boxer", 750)
    # breeder.add_breed("Golden Retriever", 2000)
    # breeder.add_breed("Dachshund", 400)

    # expect(breeder.puppies["French Bulldog"][:price]).to eq(1500)
    # expect(breeder.puppies["Shih Tzu"][:price]).to eq(500)
    # expect(breeder.puppies["Boxer"][:price]).to eq(750)
    # expect(breeder.puppies["Golden Retriever"][:price]).to eq(2000)
    # expect(breeder.puppies["Dachshund"][:price]).to eq(400)

    # New tests for database: 
    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    breeder.add_breed("French Bulldog", 1500)

    log = breeder.log

    expect(log[0].class).to eq(PuppyBreeder::Puppy)
    expect(log[0].breed).to eq("French Bulldog")
    expect(log[0].id).to eq(1)
    # expect(log[0].cost).to eq(1500)

    breeder.add_breed("Boxer", 750)

    log = breeder.log

    expect(log[1].class).to eq(PuppyBreeder::Puppy)
    expect(log[1].breed).to eq("Boxer")
    expect(log[1].id).to eq(2)
    # expect(log[1].cost).to eq(750)
  end

# Add Puppy Method Tester
  it "Adds a puppy to the container. Adds the instance to the available puppies array within the container variable" do

    # Previous Tests:
    # breeder = PuppyBreeder::Repos::PuppyContainer.new

    # puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)
    # puppy2 = PuppyBreeder::Puppy.new("Boxer", "Sadie", 1)
    # puppy3 = PuppyBreeder::Puppy.new("French Bulldog", "Butch", 2)
    # puppy4 = PuppyBreeder::Puppy.new("Golden Retriever", "Zeke", 1)

    # breeder.add_breed("French Bulldog", 1500)
    # breeder.add_breed("Boxer", 750)
    # breeder.add_breed("Golden Retriever", 2000)

    # breeder.add_puppy(puppy)
    # breeder.add_puppy(puppy2)
    # breeder.add_puppy(puppy3)
    # breeder.add_puppy(puppy4)

    # expect(breeder.puppies["French Bulldog"][:available_puppies]).to eq([puppy, puppy3])
    # expect(breeder.puppies["Boxer"][:available_puppies]).to eq([puppy2])
    # expect(breeder.puppies["Golden Retriever"][:available_puppies]).to eq([puppy4])
    # expect(breeder.puppies["French Bulldog"][:available_puppies].length).to eq(2)
    # expect(breeder.puppies["Boxer"][:available_puppies].length).to eq(1)

    # New tests for database: 
    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Jimmy", 1)

    breeder.add_puppy(puppy)

    log = breeder.log

    expect(log[0].class).to eq(PuppyBreeder::Puppy)
    expect(log[0].breed).to eq("French Bulldog")
    expect(log[0].id).to eq(1)
    # expect(log[0].name).to eq("Jimmy")
    # expect(log[0].age).to eq(1)
    # expect(log[0].cost).to eq(1500)

    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Atlas", 4)

    breeder.add_puppy(puppy2)

    log = breeder.log

    expect(log[1].class).to eq(PuppyBreeder::Puppy)
    expect(log[1].breed).to eq("Boxer")
    expect(log[1].id).to eq(2)
    # expect(log[1].name).to eq("Atlas")
    # expect(log[1].age).to eq(4)
    # expect(log[1].cost).to eq(750)

  end

# Remove Puppy Method Tester
  xit "Removes puppy from available_puppies array." do

    breeder = PuppyBreeder::Repos::PuppyContainer.new

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)
    puppy2 = PuppyBreeder::Puppy.new("French Bulldog", "Butch", 2)
    puppy3 = PuppyBreeder::Puppy.new("Golden Retriever", "Zeke", 1)
    puppy4 = PuppyBreeder::Puppy.new("Golden Retriever", "Matrix", 1)

    breeder.add_breed("French Bulldog", 1500)
    breeder.add_breed("Golden Retriever", 2000)

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)
    breeder.add_puppy(puppy3)

    breeder.remove_puppy(puppy)
    breeder.remove_puppy(puppy2)

    expect(breeder.puppies["French Bulldog"][:available_puppies].length).to eq(0)
    expect(breeder.puppies["Golden Retriever"][:available_puppies].length).to eq(1)
    expect(breeder.remove_puppy(puppy4)).to be_nil

  end

# Breed Availability Method Tester
  xit "Checks breed availability. Returns the array of puppies in that breed." do

    breeder = PuppyBreeder::PuppyContainer.new

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)
    puppy2 = PuppyBreeder::Puppy.new("French Bulldog", "Butch", 2)
    puppy3 = PuppyBreeder::Puppy.new("French Bulldog", "Stella", 1)

    breeder.add_breed("French Bulldog", 1500)
    breeder.add_breed("Dachshund", 500)

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)
    breeder.add_puppy(puppy3)

    expect(breeder.breed_availability("French Bulldog")).to eq([puppy, puppy2, puppy3])
    expect(breeder.breed_availability("Dachshund")).to be_nil

  end

end