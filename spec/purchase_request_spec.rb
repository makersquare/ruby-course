require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

# Initialize Method Tester
  it "Initializes a purchase request with breed, request_id, and request_status." do

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    expect(request.breed).to eq("French Bulldog")
    expect(request.status).to eq("Pending")
    expect(request.id).to eq(1)

    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Denied")

    expect(request2.breed).to eq("Golden Retriever")
    expect(request2.id).to eq(2)
    expect(request2.status).to eq("Denied")

  end

# Approve Purchase Request Method Tester
  it "Changes request status to Approved" do

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    expect(request.status).to eq("Pending")

    request.approve_request
    expect(request.status).to eq("Approved")

  end

# Denies Purchase Request Method Tester
  it "Changes request status to Denied" do

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    expect(request.status).to eq("Pending")

    request.deny_request
    expect(request.status).to eq("Denied")

  end

end