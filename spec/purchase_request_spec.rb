require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

  before(:each) do
    PuppyBreeder::Puppycontainer.class_variable_set(:@@pound, {})
  end

 describe 'initialize' do
  it 'initialize breed and purchaser' do 
    request = PuppyBreeder::PurchaseRequest.new("pitbull")
    request2 = PuppyBreeder::PurchaseRequest.new("pug")


    expect(request.breed).to eq("pitbull")
    expect(request2.status).to eq(:pending)
  end
end
  describe 'purchase request' do
    it 'should puts status on hold then adds to container' do 
      jill = PuppyBreeder::PurchaseRequest.new("pitbull")
      # jill_request = PuppyBreeder::Purchasecontainer.new(jill.breed)
      expect(PuppyBreeder::Puppycontainer.pound[jill.breed]).to eq(nil)
      PuppyBreeder::Purchasecontainer.purchase_request(jill)

      expect(jill.status).to eq(:hold)
    end
  end
end
