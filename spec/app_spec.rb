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

  it "has defualt cost and age of 0" do
    @dog = Puppy.new(breed:"Shephard")
    expect(@dog.breed).to eq "Shephard"
    expect(@dog.age).to eq 0
    expect(@dog.cost).to eq 0
  end
end

describe Request do
  
  before do
    @req = Request.new( 
      breed: "Shephard",
      cust_phone_number: 1111111111
      )
  end
end

describe PuppCage do

  it "PuppCage should have a hash of empty hashes for PUPPY_LIST, and an empty hash for REQUEST_LIST" do 
    expect(PuppCage::PUPPY_LIST).to eq Hash.new({cost:0, puppy:[]})
    expect(PuppCage::REQUEST_LIST).to eq Hash.new()
  end
  
  it "can add and set BREED_PRICE" do 
    PuppCage.alter_breed_price("Shephard",2000)
    expect(PuppCage::PUPPY_LIST["Shephard"][:cost]).to eq 2000
    PuppCage.alter_breed_price("Shephard",1500)
    expect(PuppCage::PUPPY_LIST["Shephard"][:cost]).to eq 1500
  end

  it "can add puppy to cage" do
    puppy = Puppy.new( 
      breed: "Shephard",
      cost: 2000,
      age:37
      )
    expect(PuppCage::PUPPY_LIST["Shephard"][:puppies].size).to eq 0
    PuppCage.add_puppy(puppy)
    expect(PuppCage::PUPPY_LIST["Shephard"][:puppies].size).to eq 1
  end

end