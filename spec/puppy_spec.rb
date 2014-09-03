require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "instantiates a new puppy object" do
    result = PuppyBreeder::Puppy.new('retriever')
    expect(result.class).to eq(PuppyBreeder::Puppy)
  end

  it "pushes newly created puppy object into Data.allpuppies" do
    result = PuppyBreeder::Puppy.new('retriever')
    (PuppyBreeder::Data.allpuppies).should include(result)
  end

  it "instantiates with name, breed, age, and status instance variables" do
    result = PuppyBreeder::Puppy.new('Kevin', 'retriever')
    expect(result.name).to eq("Kevin")
    expect(result.breed).to eq('retriever')
    expect(result.age).to eq(0)
    expect(result.status).to eq('available')
  end
end