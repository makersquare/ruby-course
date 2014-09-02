require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "creates a purchase request with a readable user and breed" do
    test_request = PuppyBreeder::PurchaseRequest.new("James","boxer")
    expect(test_request).to be_a(PuppyBreeder::PurchaseRequest)
    expect(test_request.customer).to eq("James")
    expect(test_request.breed).to eq("boxer")
  end

end