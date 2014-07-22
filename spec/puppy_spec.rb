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

  it 'has a default status of nil' do
    expect(@my_request.status).to eq(nil)
  end

  describe '#status' do
    it 'can be changed to denied, accepted, or complete' do
      expect(@my_request.deny).to eq(:denied)
      expect(@my_request.accept).to eq(:accepted)
      expect(@my_request.complete).to eq(:complete)
    end
  end 
end

# Store Class Spec

describe 'Store' do

  before do
    @store = Store.new('Puppies-R-Us', 'Nick D.')

    @brodie = Puppy.new('brodie','collie', 4015)
    @leila = Puppy.new('leila', 'collie', 10)
    @penelope = Puppy.new('penelope', 'poodle', 2)
    @ajax = Puppy.new('ajax', 'pitbull', 1)
    @harvey = Puppy.new('harvey', 'spaniel', 3065)
    @maggie = Puppy.new('maggie', 'poodle', 14)
    @skipper = Puppy.new('skipper', 'stbernard', 10)

    @new_puppies = [@brodie, @leila, @penelope, @ajax, @harvey, @maggie]
  end

  it 'initializes with a store name and owner' do
    expect(@store.name).to eq('Puppies-R-Us')
    expect(@store.owner).to eq('Nick D.')
  end

  it 'adds puppies to a hash of all breeds, with the breed pointing to an array of objects that are that breed' do
    expect(@store.add_puppy(@skipper)).to eq([@skipper])
    expect(@store.add_puppy(@brodie)).to eq([@brodie])
    expect(@store.add_puppy(@leila)).to eq([@brodie, @leila])
  end

  it 'returns puppies by breed' do
    @store.add_puppy(@brodie)
    @store.add_puppy(@leila)
    expect(@store.list_puppies('collie')).to eq(['Brodie', 'Leila'])
  end

  xit 'returns a list of all puppies of a certain breed' do
  end

  xit 'keeps track of requests' do
  end

  xit 'returns lists of puppies by their attributes' do
  end
end
