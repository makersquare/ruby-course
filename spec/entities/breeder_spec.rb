require_relative '../spec_helper.rb'

describe PuppyBreeder::Breeder do
  let(:jimmy){ PuppyBreeder::Breeder.new({
      name: 'Jimmy'
    })
  }
  let(:pit_bull){ PuppyBreeder::Breed.new({
      name: 'pit bull',
      price: 1000
    })
  }
  let(:brutus){ PuppyBreeder::Puppy.new({
      name: 'Brutus',
      breed: pit_bull
    })
  }

  describe 'initialize' do
    it 'creates a new instance of Breeder' do
      expect(jimmy).to be_a(PuppyBreeder::Breeder)
      expect(jimmy.name).to eq('Jimmy')
    end

    it 'initializes empty lists' do
      expect(jimmy.puppies.length).to eq(0)
      expect(jimmy.requests.length).to eq(0)
    end
  end

  describe 'create_request' do
    it 'creates a new purchase request' do
      jimmy.create_request({
        customer: 'Bruce',
        breed: pit_bull
      })
      expect(jimmy.requests.length).to eq(1)
      expect(jimmy.requests[:Bruce]).to be_a(PuppyBreeder::PurchaseRequest)
      expect(jimmy.requests[:Bruce].name).to eq('Bruce')
    end
  end

  describe 'add_puppy' do
    it 'adds a new puppy to the puppy list' do
      jimmy.add_puppy({})
    end
  end
end