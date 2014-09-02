require_relative 'spec_helper.rb'

describe PuppyBreeder do

  before(:each) do
    PuppyBreeder::PurchaseRequest.class_variable_set(:@@counter, 0)
  end

  before(:each) do
    PuppyBreeder.class_variable_set(:@@purchase_orders, [])
  end

  it "adds breed to puppies hash using add_breed_to_hash" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.add_breed_to_hash(mav, 500)

    expect(PuppyBreeder.puppies.count).to eq(1)
    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)
    expect(PuppyBreeder.puppies["husky"][:list]).to eq([])
  end

  it "changes the price of a breed" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.add_breed_to_hash(mav, 500)

    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)

    PuppyBreeder.change_breed_price(mav, 600)
    expect(PuppyBreeder.puppies["husky"][:price]).to eq(600)

  end

  it "adds a new puppy object to the list" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    viking = PuppyBreeder::Puppy.new("viking", "husky", 2)
    PuppyBreeder.add_breed_to_hash(mav, 500)
    PuppyBreeder.add_puppy_to_hash(mav)
    PuppyBreeder.add_puppy_to_hash(viking)

    expect(PuppyBreeder.puppies["husky"][:list][0]).to eq(mav)
    expect(PuppyBreeder.puppies["husky"][:list][1]).to eq(viking)
  end

  it "adds purchase request to purchase_orders array" do
    po = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.store_purchase_orders(po)
    po2 = PuppyBreeder::PurchaseRequest.new("chow")

    expect(PuppyBreeder.purchase_orders.length).to eq(1)
    expect(PuppyBreeder.purchase_orders.last.breed).to eq("husky")
    expect(PuppyBreeder.purchase_orders.last.status).to eq("pending")
    expect(PuppyBreeder.purchase_orders.last.id).to eq(1)

    PuppyBreeder.store_purchase_orders(po2)

    expect(PuppyBreeder.purchase_orders.length).to eq(2)
    expect(PuppyBreeder.purchase_orders.last.breed).to eq("chow")
    expect(PuppyBreeder.purchase_orders.last.status).to eq("pending")
    expect(PuppyBreeder.purchase_orders.last.id).to eq(2)
  end

  it "changes status of purchase order" do
    po = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.store_purchase_orders(po)
    PuppyBreeder.change_order_status(po, "approved")

    expect(PuppyBreeder.purchase_orders.length).to eq(1)
    expect(PuppyBreeder.purchase_orders.first.breed).to eq("husky")
    expect(PuppyBreeder.purchase_orders.first.status).to eq("approved")
  end
end