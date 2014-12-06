require_relative '../spec_helper.rb'

describe PuppyBreeder::Repos::Requests do
  let(:requests){ PuppyBreeder::Repos::Requests.new }
  let(:terrier){ PuppyBreeder.breeds_repo.create({
      name: 'terrier'
    })
  }
  let(:poodle){ PuppyBreeder.breeds_repo.create({
      name: 'poodle'
    })
  }
  let(:pit_bull){ PuppyBreeder.breeds_repo.create({
      name: 'pit bull'
    })
  }
  let(:labrador){ PuppyBreeder.breeds_repo.create({
      name: 'labrador'
    })
  }
  let(:husky){ PuppyBreeder.breeds_repo.create({
      name: 'husky'
    })
  }

  before(:each){
    requests.create({customer: 'Billy', breed: terrier})
    requests.create({customer: 'Molly', breed: poodle})
    requests.create({customer: 'Jake', breed: pit_bull})
    requests.create({customer: 'Ryan', breed: labrador})
  }

  describe 'create' do
    it 'adds a new purchase request to the list' do
      request = requests.create({customer: 'Mike', breed: poodle})
      expect(request).to be_a(PuppyBreeder::PurchaseRequest)
      expect(request.customer).to eq('Mike')
      expect(request.breed.name).to eq('poodle')
    end
  end

  describe 'update' do
    it 'updates the status of the purchase order' do
      request = requests.create({customer: 'Carl', breed: husky})
      expect(request.status).to eq('pending')
      result = requests.update({customer: 'Carl', status: 'completed'})
      expect(result.status).to eq('completed')
    end
  end

  describe 'find_by' do
    it 'returns all pending purchase orders' do
      result = requests.find_by({status: 'pending'})
      expect(result.length).to eq(4)
    end

    it 'returns all completed purchase orders' do
      requests.update({customer: 'Molly', status: 'completed'})
      requests.update({customer: 'Ryan', status: 'completed'})
      all = requests.find_by({status: 'completed'})
      expect(all.length).to eq(2)
    end

    it 'returns the purchase order of a customer' do
      request = requests.find_by({customer: 'Molly'}).first
      expect(request).to be_a(PuppyBreeder::PurchaseRequest)
      expect(request.customer).to eq('Molly')
    end

    it 'returns all purchase orders' do
      result = requests.find_by
      expect(result.length).to eq(4)
    end
  end
end