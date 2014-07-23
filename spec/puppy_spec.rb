require 'pry-byebug'
require "./puppy.rb"

# Puppy Class Spec

describe 'Puppy' do

  before do
    @brodie = Puppy.new('brodie','collie', 4015)
    @harvey = Puppy.new('harvey', 'spaniel', 3065)
    @maggie = Puppy.new('maggie', 'poodle', 14)
    @skipper = Puppy.new('skipper', 'stbernard', 10)
  end

  it 'initializes with a name, breed, and age in days' do
    expect(@brodie.name).to eq('Brodie')
    expect(@brodie.breed).to eq(:collie)
    expect(@brodie.age).to eq(4015)
  end

  it 'barks' do
    expect(@skipper.bark).to eq('BARK!')
  end
end

# Request Class Spec

describe 'Request' do
  before do
    @my_request = Request.new('Alli', 'collie')
  end

  it 'initializes with customer name, puppy breed' do
    expect(@my_request.c_name).to eq('Alli')
    expect(@my_request.breed).to eq(:collie)
  end

  it 'has a default status of :queued' do
    expect(@my_request.status).to eq(:queued)
  end

  describe '#status' do
    it 'can be changed to denied, accepted, or complete' do
      expect(@my_request.deny).to eq(:denied)
      expect(@my_request.pending).to eq(:pending)
      expect(@my_request.satisfied).to eq(:satisfied)
      expect(@my_request.hold).to eq(:holding)
    end
  end 
end

# Store Class Spec

describe 'Store' do

  before do
    @store = Store.new('Kute Kennel', 'Nick D.')

    @brodie = Puppy.new('brodie','collie', 4015)
    @leila = Puppy.new('leila', 'collie', 10)
    @penelope = Puppy.new('penelope', 'poodle', 2)
    @ajax = Puppy.new('ajax', 'pitbull', 1)
    @harvey = Puppy.new('harvey', 'spaniel', 3065)
    @maggie = Puppy.new('maggie', 'poodle', 14)
    @skipper = Puppy.new('skipper', 'stbernard', 10)
    @moog = Puppy.new('moog', 'pitbull', 4)

    @new_puppies = [@brodie, @leila, @penelope, @ajax, @harvey, @maggie]
  
    @request1 = Request.new('Alli', 'collie')
    @request2 = Request.new('Alli', 'poodle')
    @x = [@request1]
    @y = [@request1, @request2]

  end

  it 'adds puppies to a hash of all breeds, with the breed pointing to an array of objects that are that breed' do
    expect(@store.add_puppy(@skipper)).to eq([@skipper])
    expect(@store.add_puppy(@brodie)).to eq([@brodie])
    expect(@store.add_puppy(@leila)).to eq([@brodie, @leila])
  end

  it 'returns puppies by breed' do
    @store.add_puppy(@brodie)
    @store.add_puppy(@leila)
    expect(@store.list_puppies(:collie)).to eq([@brodie, @leila])
  end

  it 'initializes with a name and owner' do
    expect(@store.name).to eq('Kute Kennel')
    expect(@store.owner).to eq('Nick D.')
  end

  describe 'add-request' do
    it 'adds requests and keeps track of them' do
      @store.add_request(@request1)

      expect(@store.all_requests.size).to eq(1)

      @store.add_request(@request2)

      expect(@store.all_requests.size).to eq(2)
    end

    it 'sets status to pending or holding depending on breed availability' do
      @collie_request = Request.new('Joe', 'collie')
      @poodle_request = Request.new('Joe', 'poodle')
      @store.add_request(@collie_request)

      expect(@collie_request.status).to eq(:holding)

      @store.add_puppy(@maggie)
      @store.add_request(@poodle_request)

      expect(@poodle_request.status).to eq(:pending)
    end

    xit 'updates holding requests to pending when new puppy is added that matches request breed' do
      @store.add_request(@request1)

      expect(@request1.status).to eq(:holding)

      @store.add_puppy(@maggie)
      expect(@request1.status).to eq(:pending)
    end
  end

  it 'sets breed price' do
    @store.set_breed_price(:collie, 400)
    expect(@store.breed_prices[:collie]).to eq(400)
  end

  it 'returns price for a certain breed' do
    @store.set_breed_price(:collie, 400)
    expect(@store.return_breed_price(:collie)).to eq(400)
  end

  # xit 'can move requests in data structure depending on status' do
  # end

  it 'it returns requests of certain status' do
    @store.add_request(@request1)
    @store.add_request(@request2)
    arr = [@request1, @request2]
    expect(@store.list_requests(:holding)).to eq(arr)
    @request1.deny
    expect(@store.list_requests(:denied)).to eq([@request1])
  end

  it 'checks to see if a certain breed is available' do
    @store.add_puppy(@brodie)
    @store.add_puppy(@leila)
    puts "This is so confusing"
    puts @store.list_puppies(:pitbull)

    expect(@store.check_breed(:collie)).to eq(true)
    expect(@store.check_breed(:pitbull)).to eq(false)
  end

  # This method is for another day
  # it 'updates list if request objects have had status changed' do
  #   @store.add_request(@request1)
  #   expect(@store.list_requests(:queued)).to eq([@request1])
  #   @request1.deny
  #   expect(@store.list_requests(:queued)).to eq([])
  #   expect(@store.list_requests(:denied)).to eq([@request1])
  # end

  xit '' do
  end
# when new request is added to the store, it checks if breed is available
# if it is, status = pending
# if not, status = holding
end












