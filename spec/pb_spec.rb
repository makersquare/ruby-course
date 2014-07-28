require "file_requirements.rb"
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
    @puppy = Puppy.new(breed: "Great Dane", name: "Eleanor", age: 280)
  }

  it "creates a new instance of inventory" do
    expect(@i).to be_a Inventory
  end

  it "creates empty data structures" do
    expect(@i.inventory).to eq({})
    expect(@i.po).to eq([])
  end

  it "add a puppy to my inventory hash" do 
    addition = @i.intake_of_puppies(@puppy)
    expect(addition).to eq(@i.inventory["Great Dane"])

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
    expect(@purchase.review).to eq("Order for Elizabeth ~~~~> Breed: Great Dane")
  end

  it "Add to purchase order to inventory" do
    order = @purchase.add_purchase_order(@i)
    expect(order).to eq(@i.po)
  
  end


end
