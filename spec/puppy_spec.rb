require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "creates an instance of the puppy class" do
    dana = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 4)

    expect(dana.class).to eq(PuppyBreeder::Puppy)
  end

end

describe PuppyBreeder::Inventory do
  it 'creates a new inventory' do
    test = PuppyBreeder::Inventory.new

    expect(test.class).to eq(PuppyBreeder::Inventory)
  end
end