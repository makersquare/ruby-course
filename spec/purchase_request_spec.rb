require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

  it "Initializes a purchase request with breed, request_id, and request_status." do

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    expect(request.breed).to eq("French Bulldog")
    expect(request.request_id).to eq(1)
    expect(request.request_status).to eq("Pending")

    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Denied")

    expect(request2.breed).to eq("Golden Retriever")
    expect(request2.request_id).to eq(2)
    expect(request2.request_status).to eq("Denied")

  end

end