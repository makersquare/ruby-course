require "./puppy_breeder.rb"
require 'pry-byebug'


describe 'PurchaseRequests' do

  before do
    @request = PurchaseRequest.new("Chris", "boxer")
  end

  it 'initializes a purchase request with a name' do
    result = @request.purchaser_name

    expect(result).to eq("Chris")
  end

  it 'initializes a purchase request with a breed wanted' do
    result = @request.breed_wanted

    expect(result).to eq("boxer")
  end

  it 'initializes a purchase request with an accepted default value of false' do
    result = @request.accepted

    expect(result).to eq(false)
  end

end

describe 'PurchaseRequestInventory' do

  before do
    @request = PurchaseRequest.new("Chris", "boxer")
    @request_inventory = PurchaseRequestInventory.new
  end

  it 'initializes the inventory with an empty array' do
    expect(@request_inventory.request_array.count).to eq(0)
  end

  it 'adds purchase request to request inventory array' do
    @request_inventory.add_purchase_request(@request)
    
    expect(@request_inventory.request_array[0].purchaser_name).to eq("Chris")
  end 

  it 'views pending requests' do
    @request_inventory.add_purchase_request(@request)
    result = @request_inventory.view_requests

    expect(result).to eq(@request)
  end

  it 'accepts purchase request' do
    @request_inventory.add_purchase_request(@request)
    @request_inventory.accept_purchase_request(@request)

    expect(@request_inventory.request_array[0].accepted).to eq(true)
  end

  it 'views completed orders' do
    @request_inventory.add_purchase_request(@request)
    @request_inventory.accept_purchase_request(@request)
    result = @request_inventory.view_completed_orders

    expect(result).to eq(@request)
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
