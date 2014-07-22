require "./pupp-cage.rb"
require "./puppy.rb"
require "./request.rb"

describe Puppy do
  
  before do
    @puppy = Puppy.new( 
      breed: "Shephard",
      cost: 2000,
      age:37
      )
  end

  it "has breed, age, and cost" do 
    expect(@puppy.breed).to eq "Shephard"
    expect(@puppy.age).to eq 37
    expect(@puppy.cost).to eq 2000
  end

end

describe Request do
  
  before do
    @req = Request.new( 
      breed: "Shephard",
      cust_phone_number: 1111111111
      )
  end

  it "has breed, and custumer phone number" do 
    expect(@req.breed).to eq "Shephard"
    expect(@req.cust_phone_number).to eq 1111111111
  end

end


# describe PuppCage do
  
#   before do
#     @cage = PuppCage.new
#   end

#   it "initialize a hash of arrays for puppy_list and an empty hash for " do 
#     expect(@puppy.breed).to eq "Shephard"
#     expect(@puppy.age).to eq "37 days"
#     expect(@puppy.cost).to eq 2000
#   end

# end