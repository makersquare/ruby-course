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
    PuppyBreeder.add_breed_to_hash("husky", 500)

    expect(PuppyBreeder.puppies.count).to eq(1)
    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)
    expect(PuppyBreeder.puppies["husky"][:list]).to eq([])
  end

  it "changes the price of a breed" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.add_breed_to_hash("husky", 500)

    expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)

    PuppyBreeder.change_breed_price("husky", 600)
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
    expect(PuppyBreeder.purchase_orders.last.status).to eq(:pending)
    expect(PuppyBreeder.purchase_orders.last.id).to eq(1)

    PuppyBreeder.store_purchase_orders(po2)

    expect(PuppyBreeder.purchase_orders.length).to eq(2)
    expect(PuppyBreeder.purchase_orders.last.breed).to eq("chow")
    expect(PuppyBreeder.purchase_orders.last.status).to eq(:pending)
    expect(PuppyBreeder.purchase_orders.last.id).to eq(2)
  end

  it "changes status of purchase order" do
    PuppyBreeder.add_breed_to_hash("pug", 500)
    po = PuppyBreeder::PurchaseRequest.new("pug")
    PuppyBreeder.store_purchase_orders(po)

    expect(PuppyBreeder.purchase_orders.length).to eq(1)
    expect(PuppyBreeder.purchase_orders.first.breed).to eq("pug")
    expect(PuppyBreeder.purchase_orders.first.status).to eq(:pending)

    PuppyBreeder.review_order_status(po)

    expect(PuppyBreeder.purchase_orders.length).to eq(1)
    expect(PuppyBreeder.purchase_orders.first.breed).to eq("pug")
    expect(PuppyBreeder.purchase_orders.first.status).to eq(:on_hold)

    vik = PuppyBreeder::Puppy.new("viking", "pug", 16)
    PuppyBreeder.add_puppy_to_hash(vik)
    PuppyBreeder.review_order_status(po)

    expect(PuppyBreeder.purchase_orders.length).to eq(1)
    expect(PuppyBreeder.purchase_orders.first.breed).to eq("pug")
    expect(PuppyBreeder.purchase_orders.first.status).to eq(:complete)

  end

  it "views all complete orders" do
    po = PuppyBreeder::PurchaseRequest.new("husky", :complete)
    po1 = PuppyBreeder::PurchaseRequest.new("chow", :complete)
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.store_purchase_orders(po)
    PuppyBreeder.store_purchase_orders(po1)
    PuppyBreeder.store_purchase_orders(po2)

    result = PuppyBreeder.complete_orders


    expect(result.length).to eq(2)
    expect(result.last.id).to eq(2)

  end

  it "orders the waitlist by purchase order id number" do
    PuppyBreeder.add_breed_to_hash("bull", 500)
    PuppyBreeder.add_breed_to_hash("husky", 1000)
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    bpo1 = PuppyBreeder::PurchaseRequest.new("bull")
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    bpo3 = PuppyBreeder::PurchaseRequest.new("bull")

    PuppyBreeder.store_purchase_orders(bpo1)
    PuppyBreeder.store_purchase_orders(po2)
    PuppyBreeder.store_purchase_orders(bpo3)

    PuppyBreeder.review_order_status(bpo1)
    PuppyBreeder.review_order_status(po2)
    PuppyBreeder.review_order_status(bpo3)

    result = PuppyBreeder.waitlist
    expect(result.first.id).to eq(1)
    expect(result.last.id).to eq(3)

  end

  it "shows all purchase orders except those on hold" do
    PuppyBreeder.add_breed_to_hash("chow", 500)
    PuppyBreeder.add_breed_to_hash("husky", 1000)
    po = PuppyBreeder::PurchaseRequest.new("husky")
    po1 = PuppyBreeder::PurchaseRequest.new("chow")
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.store_purchase_orders(po)
    PuppyBreeder.store_purchase_orders(po1)
    PuppyBreeder.store_purchase_orders(po2)


    result = PuppyBreeder.active_orders

    expect(result.length).to eq(3)
  end

end