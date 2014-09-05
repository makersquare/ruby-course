require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::PuppyRepo do

# Initialize Method Tester
  it "Creates a container for all puppies the breeder has." do

    breeder = PuppyBreeder::Repos::PuppyRepo.new

    expect(breeder.class).to eq(PuppyBreeder::Repos::PuppyRepo)
    expect(breeder.log.class).to eq(Array)

  end

# Add Puppy Method Tester
  it "Adds a puppy to the container. Adds the instance to the available puppies array within the container variable" do

    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Jimmy", 1)

    breeder.add_puppy(puppy)

    log = breeder.log

    expect(log[0].class).to eq(PuppyBreeder::Puppy)
    expect(log[0].breed).to eq("French Bulldog")
    expect(log[0].id).to eq(1)

    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Atlas", 4)

    breeder.add_puppy(puppy2)

    log = breeder.log

    expect(log[1].class).to eq(PuppyBreeder::Puppy)
    expect(log[1].breed).to eq("Boxer")
    expect(log[1].id).to eq(2)

  end

  it "Returns the puppies that are listed as available." do
    
    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Jimmy", 1)
    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Atlas", 4)

    puppy.sold!

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)

    expect(breeder.show_puppies.length).to eq(1)
    expect(breeder.show_puppies.class).to eq(Array)

  end

  it "Returns the puppies listed as on hold" do

    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Jimmy", 1)
    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Atlas", 4)

    puppy.sold!
    puppy2.sold!

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)

    expect(breeder.show_sold_puppies.length).to eq(2)
    expect(breeder.show_sold_puppies.class).to eq(Array)

  end

  it "Returns the puppies listed as on hold" do

    breeder = PuppyBreeder::Repos::PuppyRepo.new
    breeder.drop_and_rebuild_tables

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Jimmy", 1)
    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Atlas", 4)

    puppy2.on_hold!

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)

    expect(breeder.show_held_puppies.length).to eq(1)
    expect(breeder.show_held_puppies.class).to eq(Array)

  end

end