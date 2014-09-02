require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequestContainer do

  it "Initializes the PuppyRequestContainer" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    expect(request_container.class).to eq(PuppyBreeder::PurchaseRequestContainer)
    expect(request_container.requests.class).to eq(Array)

  end

  it "Adds Purchase Request to the Purchase Request Container." do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Approved")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)

    expect(request_container.requests.length).to eq(3)

  end

end