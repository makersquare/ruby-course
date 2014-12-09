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
  let(:brutus){ PuppyBreeder.puppies_repo.create({
      name: 'Brutus',
      breed: pit_bull
    })
  }

  before(:each){
    PuppyBreeder.drop_tables
    PuppyBreeder.create_tables
  }

  describe 'initialize' do
    it 'creates a new instance of Breeder' do
      expect(jimmy).to be_a(PuppyBreeder::Breeder)
      expect(jimmy.name).to eq('Jimmy')
    end

    it 'initializes empty lists' do
      expect(jimmy.puppies).to be_a(PuppyBreeder::Repos::Puppies)
      expect(jimmy.requests).to be_a(PuppyBreeder::Repos::Requests)
    end
  end

  describe 'create_request' do
    it 'creates a new purchase request' do
      request = jimmy.create_request({
        customer: 'Bruce',
        breed: pit_bull
      })
      expect(request).to be_a(PuppyBreeder::PurchaseRequest)
    end
  end

  describe 'add_puppy' do
    it 'adds a new puppy to the puppy list' do
      puppy = jimmy.add_puppy({name: 'Brutus', breed: pit_bull})
      expect(puppy).to be_a(PuppyBreeder::Puppy)
      expect(puppy.name).to eq('Brutus')
    end
  end

  describe 'add_breed' do
    it 'adds a new breed to the breed list' do
      breed = jimmy.add_breed({name: 'terrier', price: 2000})
      expect(breed).to be_a(PuppyBreeder::Breed)
      expect(breed.name).to eq('terrier')
      expect(breed.price).to eq(2000)
    end
  end

  describe 'set_breed_price' do
    it 'changes the existing breed price' do
      breed = jimmy.add_breed({name: 'poodle', price: 1000})
      expect(breed.price).to eq(1000)
      breed = jimmy.set_breed_price({name: 'poodle', price: 2000})
      expect(breed.price).to eq(2000)
    end
  end

  describe 'complete_request' do
    it 'completes a purchase request' do
      request = jimmy.create_request({
        customer: 'Bruce',
        breed: pit_bull
      })
      expect(request.status).to eq('pending')
      request = jimmy.complete_request({
        customer: 'Bruce',
        puppy: brutus
      })
      expect(request.status).to eq('completed')
    end
  end

  describe 'searches requests and puppies' do 
    before(:each){
      jimmy.create_request({
        customer: 'Mark',
        breed: pit_bull
      })
      jimmy.create_request({
        customer: 'Bruce',
        breed: pit_bull
      })
      jimmy.create_request({
        customer: 'Ivan',
        breed: pit_bull
      })
      @brutus = jimmy.add_puppy({name: 'Brutus', breed: pit_bull})
      @spot = jimmy.add_puppy({name: 'Spot', breed: pit_bull})
      @lucky = jimmy.add_puppy({name: 'Lucky', breed: pit_bull})
    }

    describe 'get_requests' do
      it 'returns all requests' do
        requests = jimmy.get_requests
        expect(requests.length).to eq(3)
        expect(requests.first).to be_a(PuppyBreeder::PurchaseRequest)
      end

      it 'returns all pending requests' do
        requests = jimmy.get_requests({status: 'pending'})
        expect(requests.length).to eq(3)
        expect(requests.first).to be_a(PuppyBreeder::PurchaseRequest)
      end

      it 'returns all completed requests' do
        jimmy.complete_request({customer: 'Ivan', puppy: @brutus})
        jimmy.complete_request({customer: 'Mark', puppy: @spot})
        requests = jimmy.get_requests({status: 'completed'})
        expect(requests.length).to eq(2)
        expect(requests.first).to be_a(PuppyBreeder::PurchaseRequest)
      end
    end

    describe 'get_puppies' do
      it 'returns all puppies' do
        puppies = jimmy.get_puppies
        expect(puppies.length).to eq(3)
        expect(puppies.first).to be_a(PuppyBreeder::Puppy)
      end

      it 'returns all available puppies' do
        puppies = jimmy.get_puppies({status: 'available'})
        expect(puppies.length).to eq(3)
        expect(puppies.first).to be_a(PuppyBreeder::Puppy)
      end

      it 'returns all sold puppies' do
        jimmy.complete_request({customer: 'Ivan', puppy: @brutus})
        jimmy.complete_request({customer: 'Mark', puppy: @spot})
        puppies = jimmy.get_puppies({status: 'sold'})
        expect(puppies.length).to eq(2)
        expect(puppies.first).to be_a(PuppyBreeder::Puppy)
      end
    end
  end
end