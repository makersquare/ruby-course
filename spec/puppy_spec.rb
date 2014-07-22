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
      expect(@my_request.accept).to eq(:accepted)
      expect(@my_request.complete).to eq(:complete)
    end
  end 
end

# Kennel Class Spec

describe 'Kennel' do

  before do
    @kennel = Kennel.new('Kute Kennel', 'Nick D.')

    @brodie = Puppy.new('brodie','collie', 4015)
    @leila = Puppy.new('leila', 'collie', 10)
    @penelope = Puppy.new('penelope', 'poodle', 2)
    @ajax = Puppy.new('ajax', 'pitbull', 1)
    @harvey = Puppy.new('harvey', 'spaniel', 3065)
    @maggie = Puppy.new('maggie', 'poodle', 14)
    @skipper = Puppy.new('skipper', 'stbernard', 10)

    @new_puppies = [@brodie, @leila, @penelope, @ajax, @harvey, @maggie]
  end

  it 'initializes with a kennel name and owner' do
    expect(@kennel.name).to eq('Kute Kennel')
    expect(@kennel.owner).to eq('Nick D.')
  end

  it 'adds puppies to a hash of all breeds, with the breed pointing to an array of objects that are that breed' do
    expect(@kennel.add_puppy(@skipper)).to eq([@skipper])
    expect(@kennel.add_puppy(@brodie)).to eq([@brodie])
    expect(@kennel.add_puppy(@leila)).to eq([@brodie, @leila])
  end

  it 'returns puppies by breed' do
    @kennel.add_puppy(@brodie)
    @kennel.add_puppy(@leila)
    expect(@kennel.list_puppies('collie')).to eq(['Brodie', 'Leila'])
  end
end

describe 'Store' do

  before do
    @store = Store.new('Kute Kennel', 'Nick D.')
    @request1 = Request.new('Alli', 'collie')
    @request2 = Request.new('Alli', 'poodle')
    @x = [@request1]
    @y = [@request1, @request2]
  end

  it 'initializes with a name and owner' do
    expect(@store.name).to eq('Kute Kennel')
    expect(@store.owner).to eq('Nick D.')
  end

  it 'adds requests and keeps track of them' do
    expect(@store.add_request(@request1)).to eq(@x)
    expect(@store.add_request(@request2)).to eq(@y)
  end

  xit 'can change request status' do
  end

  xit 'it returns requests of certain status'do
  end

  xit 'keeps track of breed price' do
  end

  xit 'sets a breed price' do
  end

  xit 'returns price on breeds' do
  end

  xit 'returns lists of puppies by their attributes' do

  end

end


# :boxer => {
#   :price => num,
#   :list => [array of puppy ojects]
# }










