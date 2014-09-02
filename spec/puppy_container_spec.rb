require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyContainer do
  it "Creates a container for all puppies the breeder has." do

    breeder = PuppyBreeder::PuppyContainer.new("Cookie Fleck")

    expect(breeder.class).to eq(PuppyBreeder::PuppyContainer)
    expect(breeder.container.class).to eq(Hash)
    expect(breeder.name).to eq("Cookie Fleck")

  end

  it "Adds breeds to the container. Associates a cost with breed, and creates a available puppies array." do

    breeder = PuppyBreeder::PuppyContainer.new("Cookie Fleck")
    
    breeder.add_breed("French Bulldog", 1500)
    breeder.add_breed("Shih Tzu", 500)
    breeder.add_breed("Boxer", 750)
    breeder.add_breed("Golden Retriever", 2000)
    breeder.add_breed("Dachshund", 400)

    expect(breeder.container["French Bulldog"][:price]).to eq(1500)
    expect(breeder.container["Shih Tzu"][:price]).to eq(500)
    expect(breeder.container["Boxer"][:price]).to eq(750)
    expect(breeder.container["Golden Retriever"][:price]).to eq(2000)
    expect(breeder.container["Dachshund"][:price]).to eq(400)
  end

  it "Adds a puppy to the container. Adds the instance to the available puppies array within the container variable" do

    breeder = PuppyBreeder::PuppyContainer.new("Cookie Fleck")

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

    expect(breeder.container["French Bulldog"][:available_puppies]).to eq([puppy, puppy3])
    expect(breeder.container["Boxer"][:available_puppies]).to eq([puppy2])
    expect(breeder.container["Golden Retriever"][:available_puppies]).to eq([puppy4])

  end

end