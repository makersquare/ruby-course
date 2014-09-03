require_relative 'spec_helper.rb'

describe 'PuppyBreeder::Puppy' do

  it "A new puppy can be created with name, breed and age" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)

    #binding.pry

    expect(benson.name).to eq("Benson")
    expect(benson.age).to eq(5)
    expect(benson.breed).to eq('mut')
  end
end

describe 'PuppyBreeder::Breeder' do
  it 'Allows a breeder to add a puppy and assign a price' do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)

    expect(travis.name).to eq 'Travis'
    expect(travis.puppies.first.name).to eq 'Benson'
    expect(travis.puppies.first.price).to eq(50)
  end

  it 'Allows a breeder to add a price to a new breed of puppy and update the price on an existing breed' do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    travis.update_price('black lab', 100)
    travis.update_price('mut', 25)
    molly = PuppyBreeder::Puppy.new('Molly', "black lab", 2)
    travis.new_puppy(molly)
    expect(benson.price).to eq(25)
    expect(molly.price).to eq(100)
  end
end
