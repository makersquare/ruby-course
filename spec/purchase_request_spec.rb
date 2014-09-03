require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
 describe 'initialize' do
  it 'initialize breed and purchaser' do 
    request = PuppyBreeder::PurchaseRequest.new("pitbull")
    request2 = PuppyBreeder::PurchaseRequest.new("pug")


    expect(request.breed).to eq("pitbull")
    expect(request2.status).to eq(:pending)
  end
end
  describe ''
  describe 'purchasecontainer' do
    it 'should check the hash of the array of ppl requesting a breed' do
      jill = PuppyBreeder::PurchaseRequest.new("pitbull")
      jill_request = PuppyBreeder::Purchasecontainer.new(jill.breed)
      PuppyBreeder::Purchasecontainer.purchase_request(jill_request)

      expect(PuppyBreeder::Purchasecontainer.container.length).to eq(1)
    end
  end
end
