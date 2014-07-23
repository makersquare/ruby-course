require "./puppy_breeder.rb"
require 'pry-byebug'


describe 'PurchaseRequests' do

  before do
    @request = PurchaseRequest.new("Chris", "boxer")
  end

  it 'initializes a purchase request with a name' do
    expect(@request.purchaser_name).to eq("Chris")
  end

  it 'initializes a purchase request with a breed wanted' do
    expect(@request.breed_wanted).to eq("boxer")
  end

  it 'initializes a purchase request with the current time' do
    fake_request_time = Time.parse('5 pm')
    Time.stub(:now).and_return(fake_request_time)  
    result = PurchaseRequest.new("Aaron", "boxer")

    expect(result.request_time).to eq(fake_request_time)
  end

  it 'initializes a purchase request with a status of "pending"' do
    expect(@request.status).to eq("pending")
  end

end

describe 'PurchaseRequestInventory' do

  before do
    @request_inventory = PurchaseRequestInventory.new
    @puppy_inventory = PuppyInventory.new
    @puppy = Puppy.new(:boxer, "bowzer", 10)
    @puppy_inventory.add_puppy_to_inventory(@puppy)
    @request = PurchaseRequest.new("Chris", "boxer")
  end

  it 'initializes the inventory with an empty array' do
    expect(@request_inventory.request_array.count).to eq(0)
  end

  it 'adds purchase request to request inventory array' do
    @request_inventory.add_purchase_request(@request, @puppy_inventory)
    
    expect(@request_inventory.request_array[0].purchaser_name).to eq("Chris")
  end

  it 'views pending requests' do
    @request_inventory.add_purchase_request(@request, @puppy_inventory)

    expect(@request_inventory.view_requests.count).to eq(1)
  end

  it 'accepts purchase request' do
    @request_inventory.add_purchase_request(@request, @puppy_inventory)
    @request_inventory.accept_purchase_request(@request, @puppy)

    expect(@request_inventory.request_array[0].status).to eq("accepted")
  end

  it 'views completed orders' do
    @request_inventory.add_purchase_request(@request, @puppy_inventory)
    @request_inventory.accept_purchase_request(@request, @puppy)
    result = @request_inventory.view_completed_orders[0].status

    expect(result).to eq("accepted")
    end

  it 'changes status to "on hold" if puppy is not available' do
    @request2 = PurchaseRequest.new("Aaron", "lab")
    @request_inventory.add_purchase_request(@request2, @puppy_inventory)

    expect(@request2.status).to eq("on hold")
    expect(@request_inventory.request_array[0].status).to eq("on hold")
  end

end

describe 'Puppy' do

  before do
    @puppy = Puppy.new(:boxer, "bowzer", 10)
  end

  it 'initializes a puppy with a name' do
    expect(@puppy.name).to eq("bowzer")
  end

  it 'initializes a puppy with a breed' do
    expect(@puppy.breed).to eq(:boxer)
  end

  it 'initializes a puppy with an age' do
    expect(@puppy.age).to eq(10)
  end

  it 'initializes a puppy with an available default value of true' do
    expect(@puppy.available).to eq(true)
  end

end

describe 'PuppyInventory' do

  before do
    @puppy_inventory = PuppyInventory.new
    @puppy = Puppy.new(:boxer, "bowzer", 10)
  end

  it 'initializes the inventory with an empty hash' do
    expect(@puppy_inventory.puppy_hash.count).to eq(0)
  end

  it 'adds puppy to inventory' do
    @puppy_inventory.add_puppy_to_inventory(@puppy)

    expect(@puppy_inventory.puppy_hash.count).to eq(1)
  end

  it 'prints puppy inventory' do
    result = @puppy_inventory.print_puppy_inventory

    expect(result).to eq(@puppy_inventory.puppy_hash)
  end

end

