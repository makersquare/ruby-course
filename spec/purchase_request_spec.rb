require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "creates a new purchase request for a breed with a status of pending" do
    request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

    expect(request.breed).to eq("Golden Retriever")
    expect(request.status).to eq(:pending)
  end

end