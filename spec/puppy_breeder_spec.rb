require_relative 'spec_helper.rb'

describe PuppyBreeder do

  before(:each) do
    PuppyBreeder.puppy_repo.drop_and_rebuild
    PuppyBreeder.request_repo.drop_and_rebuild
    PuppyBreeder.breed_repo.drop_and_rebuild    
  end

  it "adds breed to puppies hash using add_breed" do
    # mav = PuppyBreeder::Puppy.new("mav", "husky", 4)
    PuppyBreeder.breed_repo.add_breed('husky', 1000)
    # this is the old way commented out
    # expect(PuppyBreeder.puppies.count).to eq(1)
    # when you call #puppy_repo.puppies you should get back an array of puppy objects
    expect(PuppyBreeder.breed_repo.breeds.count).to eq(1)
    expect(PuppyBreeder.breed_repo.breeds.first.breed).to eq('husky')
    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(1000)
    # expect(PuppyBreeder.puppies["husky"][:price]).to eq(500)
    # expect(PuppyBreeder.puppies["husky"][:list]).to eq([])
  end

  it "changes the price of a breed" do
    PuppyBreeder.breed_repo.add_breed('husky', 1000)

    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(1000)
    # expect(PuppyBreeder.puppy_repo.puppies.first.price).to eq(1000)

    PuppyBreeder.breed_repo.change_breed_price('husky', 600)

    expect(PuppyBreeder.breed_repo.breeds.first.price).to eq(600)
    # expect(PuppyBreeder.puppy_repo.puppies["husky"][:price]).to eq(600)

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

  xit "changes status of purchase order" do
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

  xit "views all complete orders" do
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

  xit "orders the waitlist by purchase order id number" do
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

  xit "shows all purchase orders except those on hold" do
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

  xit "automatically sells the puppy if there is a waitlist for that breed" do
    po = PuppyBreeder::PurchaseRequest.new("husky")
    PuppyBreeder.waitlist


    expect(PuppyBreeder.waitlist.length).to eq(1)

    mav = PuppyBreeder::Puppy.new("mav", "husky", 45)
    PuppyBreeder.add_puppy_to_hash(mav)

    expect(PuppyBreeder.waitlist.length).to eq(0)
    expect(mav.status).to eq(:purchased)
    end

end