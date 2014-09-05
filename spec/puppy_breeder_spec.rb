require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder do

  before(:each) do
    PuppyBreeder.puppy_repo.drop_and_rebuild
    PuppyBreeder.request_repo.drop_and_rebuild
    PuppyBreeder.breed_repo.drop_and_rebuild    
  end

  it "adds breed to puppies hash using add_breed" do
    PuppyBreeder.breed_repo.add_breed('husky', 1000)
    expect(PuppyBreeder.breed_repo.breeds.count).to eq(1)
    expect(PuppyBreeder.breed_repo.breeds.first.breed).to eq('husky')
    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(1000)
  end

  it "changes the price of a breed" do
    PuppyBreeder.breed_repo.add_breed('husky', 1000)
    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(1000)
    
    PuppyBreeder.breed_repo.change_breed_price('husky', 600)
    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(600)
  end

  it "adds a new puppy object to the list" do
    mav = PuppyBreeder::Puppy.new("mav", "husky", 54)
    vik = PuppyBreeder::Puppy.new("viking", "chow", 70)

    PuppyBreeder.puppy_repo.add_puppy(mav)
    PuppyBreeder.puppy_repo.add_puppy(vik)

    expect(PuppyBreeder.puppy_repo.puppies.entries.first.id).to eq(1)
    expect(PuppyBreeder.puppy_repo.puppies.entries.first.name).to eq('mav')
    expect(PuppyBreeder.puppy_repo.puppies.entries.first.adoption_status).to eq(:available)
    expect(PuppyBreeder.puppy_repo.puppies.entries[1].id).to eq(2)
    expect(PuppyBreeder.puppy_repo.puppies.entries[1].name).to eq('viking')
  end

  it "adds purchase request to purchase_orders array" do
    po = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.request_repo.store_purchase_orders(po)
    po2 = PuppyBreeder::PurchaseRequest.new("chow")

    expect(PuppyBreeder.request_repo.purchase_orders.entries.length).to eq(1)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.breed).to eq("husky")
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.status).to eq(:pending)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.id).to eq(1)

    PuppyBreeder.request_repo.store_purchase_orders(po2)

    expect(PuppyBreeder.request_repo.purchase_orders.length).to eq(2)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.breed).to eq("chow")
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.status).to eq(:pending)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.last.id).to eq(2)
  end

  it "changes status of purchase order" do
    PuppyBreeder.breed_repo.add_breed('pug', 7000)
    po = PuppyBreeder::PurchaseRequest.new("pug")
    PuppyBreeder.request_repo.store_purchase_orders(po)

    expect(PuppyBreeder.request_repo.purchase_orders.entries.length).to eq(1)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.breed).to eq("pug")
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.status).to eq(:pending)

    PuppyBreeder.request_repo.review_order_status(po)

    expect(PuppyBreeder.request_repo.purchase_orders.entries.length).to eq(1)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.breed).to eq("pug")
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.status).to eq(:on_hold)

    vik = PuppyBreeder::Puppy.new("viking", "pug", 16)
    PuppyBreeder.puppy_repo.add_puppy(vik)
    PuppyBreeder.request_repo.review_order_status(po)

    expect(PuppyBreeder.request_repo.purchase_orders.entries.length).to eq(1)
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.breed).to eq("pug")
    expect(PuppyBreeder.request_repo.purchase_orders.entries.first.status).to eq(:complete)
  end

  it "views all complete orders" do
    po = PuppyBreeder::PurchaseRequest.new("husky", :complete)
    po1 = PuppyBreeder::PurchaseRequest.new("chow", :complete)
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.request_repo.store_purchase_orders(po)
    PuppyBreeder.request_repo.store_purchase_orders(po1)
    PuppyBreeder.request_repo.store_purchase_orders(po2)

    result = PuppyBreeder.request_repo.complete_orders


    expect(result.length).to eq(2)
    expect(result.last.id).to eq(2)

  end

  it "orders the waitlist by purchase order id number" do
    PuppyBreeder.breed_repo.add_breed("bull", 500)
    PuppyBreeder.breed_repo.add_breed("husky", 1000)
    mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    bpo1 = PuppyBreeder::PurchaseRequest.new("bull")
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    bpo3 = PuppyBreeder::PurchaseRequest.new("bull")

    PuppyBreeder.request_repo.store_purchase_orders(bpo1)
    PuppyBreeder.request_repo.store_purchase_orders(po2)
    PuppyBreeder.request_repo.store_purchase_orders(bpo3)

    PuppyBreeder.request_repo.review_order_status(bpo1)
    PuppyBreeder.request_repo.review_order_status(po2)
    PuppyBreeder.request_repo.review_order_status(bpo3)

    result = PuppyBreeder.request_repo.waitlist
    expect(result.first.id).to eq(1)
    expect(result.last.id).to eq(3)

  end

  it "shows all purchase orders except those on hold" do
    PuppyBreeder.breed_repo.add_breed("chow", 500)
    PuppyBreeder.breed_repo.add_breed("husky", 1000)
    po = PuppyBreeder::PurchaseRequest.new("husky")
    po1 = PuppyBreeder::PurchaseRequest.new("chow")
    po2 = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.request_repo.store_purchase_orders(po1)
    PuppyBreeder.request_repo.store_purchase_orders(po2)


    result = PuppyBreeder.request_repo.active_orders
    expect(result.length).to eq(2)
  end

end