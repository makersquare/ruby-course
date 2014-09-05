require_relative 'spec_helper.rb'

describe PuppyPalace::Puppy do

  before(:each) do
    PuppyPalace.puppy_repo.drop_tables
    PuppyPalace.puppy_repo.build_tables
  end

  it "creates a new puppy with name, breed and age" do
    result = PuppyPalace::Puppy.new("molly","german shepherd",21)
    expect(result.class).to eq(PuppyPalace::Puppy)
  end

  it "adds puppy to database" do
    result = PuppyPalace::Puppy.new("misha","german shepherd",6)
     PuppyPalace.puppy_repo.add_puppy(result)

     expect(PuppyPalace.puppy_repo.show_pups.count).to eq(1)
  end

  it "checks name" do
    result = PuppyPalace::Puppy.new("misha","german shepherd",6)
     PuppyPalace.puppy_repo.add_puppy(result)

     expect(PuppyPalace.puppy_repo.show_pups.first.name).to eq('misha')
  end

  it "checks breed" do
    result = PuppyPalace::Puppy.new("misha","german shepherd",6)
     PuppyPalace.puppy_repo.add_puppy(result)

     expect(PuppyPalace.puppy_repo.show_pups.first.breed).to eq('german shepherd')
  end

  it "checks age" do
    result = PuppyPalace::Puppy.new("misha","german shepherd",6)
     PuppyPalace.puppy_repo.add_puppy(result)

     expect(PuppyPalace.puppy_repo.show_pups.first.age).to eq(6)
  end
end