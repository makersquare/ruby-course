require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequestContainer do

  it "Initializes the PuppyRequestContainer" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    expect(request_container.class).to eq(PuppyBreeder::PurchaseRequestContainer)
    expect(request_container.requests.class).to eq(Hash)

  end

  it "Adds Purchase Request to the Purchase Request Container." do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Approved")
    request4 = PuppyBreeder::PurchaseRequest.new("Shih Tzu", "Denied")
    request5 = PuppyBreeder::PurchaseRequest.new("Shih Tzu", "Denied")
    request6 = PuppyBreeder::PurchaseRequest.new("Shih Tzu", "Denied")
    request7 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Approved")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)
    request_container.add_request(request7)

    expect(request_container.requests["Pending"][1]).to eq(request2)
    expect(request_container.requests["Pending"].length).to eq(2)
    expect(request_container.requests["Approved"].length).to eq(2)
    expect(request_container.requests["Denied"].length).to eq(3)

  end

end