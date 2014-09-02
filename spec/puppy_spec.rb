require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it "creates a puppy with breed,name,age" do
    test_puppy = PuppyBreeder::Puppy.new(breed: "boxer",name:"Rex",age_in_days:30)
    expect(test_puppy).to be_a(PuppyBreeder::Puppy)
  end

  it "can access all those variables" do
    test_puppy = PuppyBreeder::Puppy.new(breed: "boxer",name:"Rex",age_in_days:30)
    expect(test_puppy.breed).to eq("boxer")
    expect(test_puppy.name).to eq("Rex")
    expect(test_puppy.age_in_days).to eq(30)
  end
end