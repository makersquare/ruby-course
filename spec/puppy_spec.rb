require './puppy.rb'
require 'rspec'


describe PuppyMill::Puppy do
  before(:all) do
    @spot = PuppyMill::Puppy.new(breed: 'dalmation', name: 'Spot', age: 100)
    @rex = PuppyMill::Puppy.new(name: 'Rex', breed: 'great dane', age: 365)
  end

  it "initializes with a name" do
    @spot.name.should eq 'Spot'
  end

  it "initializes with a breed" do
    @spot.breed.should eq 'dalmation'
  end

  it "initializes with an age" do
    @spot.age.should eq 100
  end

  it "allows breeder to input new puppies" do
    @rex.should_not be_nil
  end

end

describe PuppyMill::PurchaseOrder do
  before(:all) do
    @rex = PuppyMill::Puppy.new(name: 'Rex', breed: 'great dane', age: 365)
    @spot = PuppyMill::Puppy.new(breed: 'dalmation', name: 'Spot', age: 100)
    @fido = PuppyMill::Puppy.new(breed: 'poodle', name: 'Fido', age: 100)
    @purchase = PuppyMill::PurchaseOrder.new(customer_name: 'Joe Dirt', breed: 'dalmation' )
  end

  it "allows breeder to create purchase orders" do
    @purchase.customer_name.should eq 'Joe Dirt'
    @purchase.breed.should eq 'dalmation'
  end

  it "allows breeder to review purchase orders" do
    @purchase.review.should eq "customer: Joe Dirt, puppy breed: dalmation"
  end

  it "allows breeder to accept purchase order" do
    @purchase.accept
    PuppyMill::PurchaseOrders.view_all.first.should be @purchase
  end


  it "allows breeder to check if a purchase order can be satisfied" do
    PuppyMill::Puppies.add_pup(@spot)
    @purchase.satisfy_order?.should be_true
  end
end
