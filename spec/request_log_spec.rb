require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::RequestLog do
  before(:all) do
    PuppyBreeder.request_repo.drop_tables
    @order1 = PuppyBreeder::PurchaseRequest.new("Boxer")
    @order2 = PuppyBreeder::PurchaseRequest.new("Great Dane")
    @order3 = PuppyBreeder::PurchaseRequest.new("Poodle")
    @order4 = PuppyBreeder::PurchaseRequest.new("Greyhound")
    PuppyBreeder.request_repo.add_purchase_request(@order1)
    PuppyBreeder.request_repo.add_purchase_request(@order2)
    PuppyBreeder.request_repo.add_purchase_request(@order3)
    PuppyBreeder.request_repo.add_purchase_request(@order4)
  end

  describe '#add_purchase_request' do
    it 'adds a purchase request to the database' do
      expect{PuppyBreeder.request_repo.add_purchase_request(@order4)}.to change{PuppyBreeder.request_repo.log.size}.by(1)
    end
  end

  describe '#get_completed_requests' do
    it 'returns the orders which have a status of complete' do
      res = PuppyBreeder.request_repo.get_completed_requests
      expect(res.size).to eq(0)
    end
  end

  describe '#review_purchase_request' do
    it 'returns orders which has a status of pending' do
      res1 = PuppyBreeder.request_repo.review_purchase_request.sample.status
      expect(res1).to eq('pending')
    end
  end

  describe '#accept_purchase_request' do
    it 'accept the purchase requests' do
      PuppyBreeder.request_repo.accept_purchase_request
      expect(PuppyBreeder.request_repo.get_completed_requests.sample.status).to eq('complete')
    end
  end
end