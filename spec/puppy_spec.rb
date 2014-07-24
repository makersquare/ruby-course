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

describe PuppyMill::Puppies do
  before(:all) do
    @spot = PuppyMill::Puppy.new(breed: 'dalmation', name: 'Spot', age: 100)
    @rex = PuppyMill::Puppy.new(name: 'Rex', breed: 'great dane', age: 365)
  end

  it "allows breeder to add puppies to inventory" do
    PuppyMill::Puppies.add_pup(@spot)
    PuppyMill::Puppies.add_pup(@rex)
    PuppyMill::Puppies.all_pups.size.should eq 2
  end

  it ".breed_available? returns true if breed is available" do
    PuppyMill::Puppies.breed_available?(@rex.breed)
  end
end

describe PuppyMill::PurchaseOrder do
  before(:all) do
    @rex = PuppyMill::Puppy.new(name: 'Rex', breed: 'great dane', age: 365)
    @spot = PuppyMill::Puppy.new(breed: 'dalmation', name: 'Spot', age: 100)
    @fido = PuppyMill::Puppy.new(breed: 'poodle', name: 'Fido', age: 100)
    @purchase = PuppyMill::PurchaseOrder.new(customer_name: 'Joe Dirt', breed: 'dalmation' )
    @purchase2 = PuppyMill::PurchaseOrder.new(customer_name: 'Joe Dirt', breed: 'poodle' )
  end

  it "allows breeder to create purchase orders" do
    @purchase.customer_name.should eq 'Joe Dirt'
    @purchase.breed.should eq 'dalmation'
  end

  it "allows breeder to review purchase orders" do
    @purchase.review.should eq "customer: Joe Dirt, puppy breed: dalmation"
  end

  it "initializes with a default :pending status" do
    @purchase.status.should eq :pending
  end
end

describe PuppyMill::PurchaseOrders do
  before(:all) do
    @rex = PuppyMill::Puppy.new(name: 'Rex', breed: 'great dane', age: 365)
    @spot = PuppyMill::Puppy.new(breed: 'dalmation', name: 'Spot', age: 100)
    @fido = PuppyMill::Puppy.new(breed: 'poodle', name: 'Fido', age: 100)
    @purchase = PuppyMill::PurchaseOrder.new(customer_name: 'Joe Dirt', breed: 'dalmation' )
    @purchase2 = PuppyMill::PurchaseOrder.new(customer_name: 'Billy Bob', breed: 'poodle' )
  end

  it "allows breeder to add purchase orders to store" do
    PuppyMill::PurchaseOrders.add_order(@purchase)
    PuppyMill::PurchaseOrders.add_order(@purchase2)
    PuppyMill::PurchaseOrders.orders.size.should eq 2
  end

  it ".fulfill_order? returns false if breed not available" do
    PuppyMill::PurchaseOrders.fulfill_order?(@purchase)
  end

  it ".fulfill_order? returns true if breed is available" do
    PuppyMill::Puppies.add_pup(@spot)
    PuppyMill::PurchaseOrders.fulfill_order?(@purchase2)
  end

  it ".modify_hold_orders changes order status if breed becomes available" do
    # PuppyMill::PurchaseOrders.add_order(@purchase2)
    @purchase2.status.should eq :hold

    PuppyMill::PurchaseOrders.modify_hold_orders(@fido)
    @purchase2.status.should eq :pending
  end

  it ".accept allows breeder to accept orders" do
    PuppyMill::PurchaseOrders.accept(@purchase2)
    @purchase2.status.should eq :accepted
  end

  it ".deny allows breeder to deny orders" do
    PuppyMill::PurchaseOrders.deny(@purchase2)
    @purchase2.status.should eq :denied
  end

  it ".view_all_accepted_orders displays all accepted orders" do
    PuppyMill::PurchaseOrders.accept(@purchase2)
    PuppyMill::PurchaseOrders.accept(@purchase)
    PuppyMill::PurchaseOrders.view_all_accepted_orders.include?(@purchase).should be_true
    PuppyMill::PurchaseOrders.view_all_accepted_orders.include?(@purchase2).should be_true
  end
end
