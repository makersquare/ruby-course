require_relative 'spec_helper.rb'

describe PuppyPalace::PurchaseRequest do
  # before(:each) do ... end
  # this is a before hook
  # read the docs son.
  # someclass.class_variable_set

  before(:each) do
    PuppyPalace.request_repo.drop_tables
    PuppyPalace.request_repo.build_tables
  end
  
  it "creates a purchase request" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")
    expect(result.class).to eq(PuppyPalace::PurchaseRequest)
  end

  it "creates purchase request for german shepherds" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")
    expect(result.breed).to eq("german shepherd")
  end

  it "checks that status is pending" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")

    expect(result.status).to eq("pending")
  end

  # it "checks that id is 0" do
  #   result = PuppyPalace::PurchaseRequest.new("german shepherd")
  #   expect(result.id_num).to eq(0)
  # end

  # it "checks that id is 0 for first request and 1 for second" do
  #   result1 = PuppyPalace::PurchaseRequest.new("german shepherd")
  #   result2 = PuppyPalace::PurchaseRequest.new("german shepherd")

  #   expect(result1.id_num).to eq(0)
  #   expect(result2.id_num).to eq(1)
  # end

  it "shows there is 1 current open order" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(result)

    expect(PuppyPalace.request_repo.open_orders.count).to eq(1)
  end

  it "shows there are 2 current open orders" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")
    result1 = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(result)
    PuppyPalace.request_repo.add_request(result1)

    expect(PuppyPalace.request_repo.open_orders.count).to eq(2)
  end

  it "changes pending to accepted" do
    # binding.pry
    result = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(result)

    id = PuppyPalace.request_repo.open_orders.first.id

    # req = PuppyPalace.request_repo.find_request(result.id)

    # result.accept

    # expect(result.status).to eq("accepted")

    PuppyPalace.request_repo.accept!(id)

    expect(PuppyPalace.request_repo.open_orders.first.status).to eq(:accepted)
  end

  it "changes pending to rejected" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")
    PuppyPalace.request_repo.add_request(result)
    id = PuppyPalace.request_repo.open_orders.first.id

    PuppyPalace.request_repo.reject!(id)
    expect(PuppyPalace.request_repo.open_orders.first.status).to eq(:rejected)
    # PuppyPalace::PurchaseRequest.reject(0)
    # expect(PuppyPalace::PurchaseRequest.open_orders[0].status).to eq('rejected')
  end

  it "shows completed orders" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(result)

    id = PuppyPalace.request_repo.open_orders.first.id
    PuppyPalace.request_repo.accept!(id)

    expect(PuppyPalace.request_repo.show_orders.count).to eq(1)
    # expect(PuppyPalace::PurchaseRequest.completed.count).to eq(0)

    # PuppyPalace::PurchaseRequest.accept(0)

    # expect(PuppyPalace::PurchaseRequest.completed.count).to eq(1)
  end

  it "puts order on hold" do
    result = PuppyPalace::PurchaseRequest.new("german shepherd")
    PuppyPalace.request_repo.add_request(result)
    id = PuppyPalace.request_repo.open_orders.first.id

    PuppyPalace.request_repo.hold!(id)
    expect(PuppyPalace.request_repo.open_orders.first.status).to eq(:on_hold)
  end

  it "shows orders, excluding holding orders" do
    r1 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r2 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r3 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r4 = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(r1)
    PuppyPalace.request_repo.add_request(r2)
    PuppyPalace.request_repo.add_request(r3)
    PuppyPalace.request_repo.add_request(r4)

    id = PuppyPalace.request_repo.open_orders.first.id
    PuppyPalace.request_repo.hold!(id)

    expect(PuppyPalace.request_repo.show_exclude_hold.count).to eq(3)
  end

  it "shows holding orders" do
    r1 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r2 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r3 = PuppyPalace::PurchaseRequest.new("german shepherd")
    r4 = PuppyPalace::PurchaseRequest.new("german shepherd")

    PuppyPalace.request_repo.add_request(r1)
    PuppyPalace.request_repo.add_request(r2)
    PuppyPalace.request_repo.add_request(r3)
    PuppyPalace.request_repo.add_request(r4)

    id = PuppyPalace.request_repo.open_orders.first.id
    PuppyPalace.request_repo.hold!(id)

    expect(PuppyPalace.request_repo.show_hold.count).to eq(1)
  end

  # xit "shows holding orders and confirms that they are in the correct order" do
  #   PuppyPalace::PurchaseRequest.new("german shepherd")
  #   PuppyPalace::PurchaseRequest.new("german shepherd")
  #   PuppyPalace::PurchaseRequest.new("german shepherd")
  #   PuppyPalace::PurchaseRequest.new("german shepherd")

  #   PuppyPalace::PurchaseRequest.hold(0)
  #   PuppyPalace::PurchaseRequest.hold(3)
    
  #   expect(PuppyPalace::PurchaseRequest.on_hold.first.id_num).to eq(0)
  #   expect(PuppyPalace::PurchaseRequest.on_hold.last.id_num).to eq(3)
  # end
end

# describe PuppyPalace::Breeder do
#   it "adds puppy to hash of puppies" do
#     puppy = PuppyPalace::Puppy.new("molly","german shepherd",21)
#     breeder = PuppyPalace::Breeder.new("Joe-Shmoe")

#     breeder.add_puppy(puppy)

#     expect(breeder.all_puppies[puppy.breed][:list].last.name).to eq("molly")
#   end

#   it "adds two puppies and checks that both are present" do
#   end
# end

require_relative '../lib/puppy_breeder/entities/puppy.rb'
require_relative '../lib/puppy_breeder/entities/request.rb'
require_relative '../lib/puppy_breeder/databases/request_repo.rb'
require_relative '../lib/puppy_breeder/databases/puppy_repo.rb'