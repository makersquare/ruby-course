require_relative 'spec_helper.rb'

describe PuppyBreeder do
  it "adds breed to puppies hash using add_breed_to_hash" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.add_breed_to_hash(mav, 500)

    expect(PuppyBreeder.puppies.count).to eq(1)
    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)
    expect(PuppyBreeder.puppies["husky"][:list]).to eq([])
  end

  it "changes the price of a breed" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.add_breed_to_hash(mav, 500)

    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)

    PuppyBreeder.change_breed_price(mav, 600)
    expect(PuppyBreeder.puppies["husky"][:price]).to eq(600)

  end

end