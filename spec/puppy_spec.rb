require_relative 'spec_helper.rb'

describe PAWS::Puppy do
  it "creates a puppy with breed,name,age,status,id" do
    test_puppy = PAWS::Puppy.new("boxer","Rex",30)
    expect(test_puppy).to be_a(PAWS::Puppy)
  end

  it "can access all those variables" do
    test_puppy = PAWS::Puppy.new("boxer","Rex",30)
    expect(test_puppy.name).to eq("Rex")
    expect(test_puppy.breed).to eq("boxer")
    expect(test_puppy.age_in_days).to eq(30)
    expect(test_puppy.status).to eq(:available)
    expect(test_puppy.id).to eq(nil)
  end

  it "can check and change status" do
    test_puppy = PAWS::Puppy.new("boxer","Rex",30)
    expect(test_puppy.status).to eq(:available)
    test_puppy.adopted!
    expect(test_puppy.status).to eq(:adopted)
  end

end