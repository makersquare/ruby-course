require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::RequestLog do
  before(:each) do
    PuppyBreeder.request_repo.drop_tables
    @request1 = PuppyBreeder::PurchaseRequest.new("Boxer")
    @request2 = PuppyBreeder::PurchaseRequest.new("Great Dane")
    @request3 = PuppyBreeder::PurchaseRequest.new("Poodle")
    @request4 = PuppyBreeder::PurchaseRequest.new("Greyhound")
    PuppyBreeder.request_repo.add_purchase_request(@request1)
    PuppyBreeder.request_repo.add_purchase_request(@request2)
    PuppyBreeder.request_repo.add_purchase_request(@request3)
    PuppyBreeder.request_repo.add_purchase_request(@request4)
  end

  describe '#add_purchase_request' do
    it 'adds a purchase request to the database' do
      expect{PuppyBreeder.request_repo.add_purchase_request(@request4)}.to change{PuppyBreeder.request_repo.log.size}.by(1)
    end
  end

  describe '#update_purchase_request' do
    it 'updates a purchase request based on id' do
      @request3.breed = "Hound"
      PuppyBreeder.request_repo.update_purchase_request(@request3)
      result = PuppyBreeder.request_repo.log.last
      expect(result.breed).to eq("Hound")
    end
  end

  describe '#get_completed_requests' do
    it 'returns the requests which have a status of complete' do
      res = PuppyBreeder.request_repo.get_completed_requests
      expect(res.size).to eq(0)
    end
  end

  describe '#review_purchase_request' do
    it 'returns requests which has a status of pending' do
      res1 = PuppyBreeder.request_repo.review_purchase_request.first.status
      expect(res1).to eq('pending')
    end
  end

  describe '#accept_purchase_request' do
    it 'accept the purchase requests for given purchase request object' do
      PuppyBreeder.request_repo.accept_purchase_request(@request2)
      expect(PuppyBreeder.request_repo.get_completed_requests.first.status).to eq('complete')
    end
  end
end