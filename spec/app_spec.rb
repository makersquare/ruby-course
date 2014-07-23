require "./pupp-cage.rb"
require "./puppy.rb"
require "./request.rb"

describe Puppy do
  
  before do
    @puppy = Puppy.new( 
      breed: "Shephard",
      age:37
      )
  end

  it "has breed and  age" do 
    expect(@puppy.breed).to eq "Shephard"
    expect(@puppy.age).to eq 37
  end

  it "has defualt age of 0" do
    @dog = Puppy.new(breed:"Shephard")
    expect(@dog.breed).to eq "Shephard"
    expect(@dog.age).to eq 0
  end
end

describe Request do

  it "has breed and cust_phone_number" do
    req = Request.new( 
      breed: "Shephard",
      cust_phone_number: 1111111111
      )
    expect(req.breed).to eq "Shephard"
    expect(req.cust_phone_number).to eq 1111111111
  end
end
  
describe PuppCage do
  
  it "can add and set BREED_PRICE" do 
    PuppCage.alter_breed_price("Shephard",2000)
    expect(PuppCage::PUPPY_LIST["Shephard"][:cost]).to eq 2000
    PuppCage.alter_breed_price("Shephard",1500)
    expect(PuppCage::PUPPY_LIST["Shephard"][:cost]).to eq 1500
  end

  it "can add puppy to cage" do
    puppy = Puppy.new( 
      breed: "Shephard",
      age:37
      )

    expect(PuppCage::PUPPY_LIST[puppy.breed][:puppies]).to eq nil
    PuppCage.add_puppy(puppy)
    expect(PuppCage::PUPPY_LIST[puppy.breed][:puppies].size).to eq 1
  end

  it "can remove puppy from cage" do
    puppy = Puppy.new( 
      breed: "Beagle",
      age:37
      )

    PuppCage.add_puppy(puppy)

    expect(PuppCage::PUPPY_LIST[puppy.breed][:puppies].size).to eq 1
    PuppCage.remove_puppy(puppy)
    expect(PuppCage::PUPPY_LIST[puppy.breed][:puppies].size).to eq 0    
  end

  it "can add request" do
    info = "Shephard"
    cust_phone_number = 1111111111
    expect(PuppCage::REQUEST_LIST.size).to eq 0
    PuppCage.add_request(cust_phone_number,info)
    expect(PuppCage::REQUEST_LIST.size).to eq 1
  end

  it "can remove request" do
    expect(PuppCage::REQUEST_LIST.size).to eq 1
    PuppCage.remove_request(1111111111)
    expect(PuppCage::REQUEST_LIST.size).to eq 0
  end
  
end