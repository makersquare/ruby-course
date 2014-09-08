require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Inventory do
  xit 'creates a new inventory' do
    test = PuppyBreeder::Inventory.new

    expect(test.class).to eq(PuppyBreeder::Inventory)
  end

  xit 'adds a breed to the inventory' do
    test = PuppyBreeder::Inventory
    test.add_breed("Schnauzer", 500)
    test.add_breed("Mutt", 1000)

    expect(test.puppies["Schnauzer"]["price"]).to eq(500)
    expect(test.puppies["Mutt"]["price"]).to eq(1000)
  end

  xit 'adds a puppy to the inventory' do
    test = PuppyBreeder::Inventory
    test.add_breed("Schnauzer", 500)
    puppy = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 1)
    test.add_puppy(puppy)

    expect(test.puppies["Schnauzer"]["list"]).to include(puppy)
  end
end