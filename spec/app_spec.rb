require "./pupp-cage.rb"
require "./puppy.rb"
require "./request.rb"

describe Puppy do
  
  before do
    @puppy = Puppy.new({ 
      breed: "Shephard"
      age:"37 days"
      cost: 2000
      })
  end

  it "has breed, age, and cost" do 
    expect(puppy.breed).to eq "Shephard"
    expect(puppy.age).to eq "37 days"
    expect(puppy.cost).to eq 2000
  end

end