require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  # before(:each) do ... end
  # this is a before hook
  # read the docs son.
  # someclass.class_variable_set

  before(:each) do
    PuppyBreeder::PurchaseRequest.class_variable_set(:@@id_count, 0)
    PuppyBreeder::PurchaseRequest.class_variable_set(:@@open_orders, {})
  end
  
  it "creates a purchase request" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.class).to eq(PuppyBreeder::PurchaseRequest)
  end

  it "creates purchase request for german shepherds" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.breed).to eq("german shepherd")
  end

  it "checks that status is pending" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.status).to eq("pending")
  end

  it "checks that id is 0" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.id_num).to eq(0)
  end

  it "checks that id is 0 for first request and 1 for second" do
    result1 = PuppyBreeder::PurchaseRequest.new("german shepherd")
    result2 = PuppyBreeder::PurchaseRequest.new("german shepherd")

    expect(result1.id_num).to eq(0)
    expect(result2.id_num).to eq(1)
  end

  it "shows there is 1 current open order" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")

    expect(PuppyBreeder::PurchaseRequest.open_orders.count).to eq(1)
  end

  it "shows there are 2 current open orders" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    result1 = PuppyBreeder::PurchaseRequest.new("german shepherd")

    expect(PuppyBreeder::PurchaseRequest.open_orders.count).to eq(2)
  end

  it "changes pending to accepted" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")

    PuppyBreeder::PurchaseRequest.accept(0)
    expect(PuppyBreeder::PurchaseRequest.open_orders[0].status).to eq('accepted')
  end

  it "changes pending to rejected" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")

    PuppyBreeder::PurchaseRequest.reject(0)
    expect(PuppyBreeder::PurchaseRequest.open_orders[0].status).to eq('rejected')
  end

    it "shows completed orders" do
    request = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(PuppyBreeder::PurchaseRequest.completed.count).to eq(0)

    PuppyBreeder::PurchaseRequest.accept(0)

    expect(PuppyBreeder::PurchaseRequest.completed.count).to eq(1)
  end
end

describe PuppyBreeder::Breeder do
  it "adds puppy to hash of puppies" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)

    expect(breeder.all_puppies[puppy.breed][:list].last.name).to eq("molly")
  end

  it "adds two puppies and checks that both are present" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    puppy1 = PuppyBreeder::Puppy.new("joe","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy1)

    expect(breeder.all_puppies[puppy.breed][:list].first.name).to eq("molly")
    expect(breeder.all_puppies[puppy.breed][:list].last.name).to eq("joe")
  end

  it "checks that price is set to nil" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)

    expect(breeder.all_puppies[puppy.breed][:price]).to be(nil)
  end

  it "sets the price to the designated price" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)
    breeder.set_price("german shepherd","1000")

    expect(breeder.all_puppies[puppy.breed][:price]).to eq("1000")
  end
end