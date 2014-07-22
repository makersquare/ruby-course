require "./puppybreeder.rb"
require "pry-byebug"

describe Puppy, "#new" do
  
  before{
    @puppy = Puppy.new(breed: "Great Dane", name: "Eleanor", age: 280)
  }

  it "creates a new instance of puppy" do
    expect(@puppy).to be_a Puppy
  end

end

describe Inventory do 

  before {
    @i = Inventory.new
  }

  it "creates a new instance of inventory" do
    expect(@i).to be_a Inventory
  end

  it "creates empty data structures" do
    expect(@i.inventory).to eq([])
    expect(@i.po).to eq([])
  end
end

describe PurchaseOrder do
  
  before {
    
    @puppy = Puppy.new(breed: "Great Dane", name: "Eleanor", age: 280)
    @purchase = PurchaseOrder.new(customer: "Elizabeth", breed: "Great Dane")
    @i = Inventory.new

  }

  it "creates a new instance of purchaseorder" do
    expect(@purchase).to be_a PurchaseOrder
  end

  it "Review a Purchase Order" do
    expect(@purchase.review).should eq("Order for Elizabeth ~~~~> Breed: Great Dane")
  end

  it "Add to purchase order to inventory" do
    
    expect(@i.po.empty?).should be_true
    order = @purchase.add(@i)
    expect(order).to eq(@i.po)
  
  end


end
