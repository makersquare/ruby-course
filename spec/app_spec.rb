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

# describe Request do
  
#   before do
#     @req = Request.new( 
#       breed: "Shephard",
#       cust_phone_number: 1111111111
#       )
#   end

# end
  
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

  it "checks if hash contains breed type" do
    breed="Cat"
    expect(PuppCage.breed_type_exists?(breed)).to eq false

    breed="Beagle"
    expect(PuppCage.breed_type_exists?(breed))
  end


end