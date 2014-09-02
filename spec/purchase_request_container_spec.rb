require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequestContainer do

# Initialize Method Tester
  it "Initializes the PuppyRequestContainer" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    expect(request_container.class).to eq(PuppyBreeder::PurchaseRequestContainer)
    expect(request_container.requests.class).to eq(Array)

  end

# Add Request Method Tester
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

# Completed Requests Method Tester
  it "Returns an array of all completed (approved or denied) requests" do 

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Denied")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Denied")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Denied")
    request5 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Approved")
    request6 = PuppyBreeder::PurchaseRequest.new("Golden Retriever", "Approved")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    expect(request_container.completed_requests).to be_a(Array)
    expect(request_container.completed_requests).to eq([request2, request3, request4, request5, request6])
    expect(request_container.completed_requests.length).to eq(5)

  end

# Pending Requests Method Tester
  it "Returns all pending requests" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Shih Tzu")
    request5 = PuppyBreeder::PurchaseRequest.new("Boxer")
    request6 = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    request2.approve_request
    request3.deny_request
    request5.approve_request

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    expect(request_container.pending_requests.class).to eq(Array)
    expect(request_container.pending_requests).to eq([request, request4, request6])
    expect(request_container.pending_requests.length).to eq(3)

  end

# Approved Requests Method Tester
  it "Returns all approved requests" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Shih Tzu")
    request5 = PuppyBreeder::PurchaseRequest.new("Boxer")
    request6 = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    request2.approve_request
    request3.deny_request
    request5.approve_request

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    expect(request_container.approved_requests.class).to eq(Array)
    expect(request_container.approved_requests).to eq([request2, request5])
    expect(request_container.approved_requests.length).to eq(2)

  end

# Denied Requests Method Tester
  it "Returns all denied requests" do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Shih Tzu")
    request5 = PuppyBreeder::PurchaseRequest.new("Boxer")
    request6 = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    request2.approve_request
    request3.deny_request
    request5.approve_request

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    expect(request_container.denied_requests.class).to eq(Array)
    expect(request_container.denied_requests).to eq([request3])
    expect(request_container.denied_requests.length).to eq(1)

  end

# Requests by Breed Method Tester
  it "Returns an array of all requests by breed." do

    request_container = PuppyBreeder::PurchaseRequestContainer.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request5 = PuppyBreeder::PurchaseRequest.new("French Bulldog")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)

    expect(request_container.requests_of_a_breed("French Bulldog").class).to eq(Array)
    expect(request_container.requests_of_a_breed("French Bulldog")).to eq([request, request5])
    expect(request_container.requests_of_a_breed("French Bulldog").length).to eq(2)

    expect(request_container.requests_of_a_breed("Golden Retriever").class).to eq(Array)
    expect(request_container.requests_of_a_breed("Golden Retriever")).to eq([request2, request3, request4])
    expect(request_container.requests_of_a_breed("Golden Retriever").length).to eq(3)

  end  

end