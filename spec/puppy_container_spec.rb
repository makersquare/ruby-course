require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyContainer do
  it "Creates a container for all puppies the breeder has." do

    breeder = PuppyBreeder::PuppyContainer.new

    expect(breeder.class).to eq(PuppyBreeder::PuppyContainer)
    expect(breeder.puppies.class).to eq(Hash)

  end

  it "Adds breeds to the container. Associates a cost with breed, and creates a available puppies array." do

    breeder = PuppyBreeder::PuppyContainer.new
    
    breeder.add_breed("French Bulldog", 1500)
    breeder.add_breed("Shih Tzu", 500)
    breeder.add_breed("Boxer", 750)
    breeder.add_breed("Golden Retriever", 2000)
    breeder.add_breed("Dachshund", 400)

    expect(breeder.puppies["French Bulldog"][:price]).to eq(1500)
    expect(breeder.puppies["Shih Tzu"][:price]).to eq(500)
    expect(breeder.puppies["Boxer"][:price]).to eq(750)
    expect(breeder.puppies["Golden Retriever"][:price]).to eq(2000)
    expect(breeder.puppies["Dachshund"][:price]).to eq(400)
  end

  it "Adds a puppy to the container. Adds the instance to the available puppies array within the container variable" do

    breeder = PuppyBreeder::PuppyContainer.new

    puppy = PuppyBreeder::Puppy.new("French Bulldog", "Murphy", 3)
    puppy2 = PuppyBreeder::Puppy.new("Boxer", "Sadie", 1)
    puppy3 = PuppyBreeder::Puppy.new("French Bulldog", "Butch", 2)
    puppy4 = PuppyBreeder::Puppy.new("Golden Retriever", "Zeke", 1)

    breeder.add_breed("French Bulldog", 1500)
    breeder.add_breed("Boxer", 750)
    breeder.add_breed("Golden Retriever", 2000)

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy2)
    breeder.add_puppy(puppy3)
    breeder.add_puppy(puppy4)

    expect(breeder.puppies["French Bulldog"][:available_puppies]).to eq([puppy, puppy3])
    expect(breeder.puppies["Boxer"][:available_puppies]).to eq([puppy2])
    expect(breeder.puppies["Golden Retriever"][:available_puppies]).to eq([puppy4])
    expect(breeder.puppies["French Bulldog"][:available_puppies].length).to eq(2)
    expect(breeder.puppies["Boxer"][:available_puppies].length).to eq(1)

  end

end