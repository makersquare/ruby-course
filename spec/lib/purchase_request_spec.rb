require_relative '../spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  let(:terrier){ PuppyBreeder::Breed.new({
      name: 'terrier',
      price: 2000
    })
  }
  let(:request){PuppyBreeder::PurchaseRequest.new({
      customer: 'Billy',
      breed: terrier
    })
  }

  describe 'initialize' do
    it "creates a new p.o. with a breed and a customer's name" do
      expect(request).to be_a(PuppyBreeder::PurchaseRequest)
      expect(request.breed).to be_a(PuppyBreeder::Breed)
      expect(request.breed.name).to eq('terrier')
      expect(request.customer).to eq('Billy')
    end

    it 'initializes purchase request statuses' do
      expect(request.status).to eq('pending')
    end
  end
end