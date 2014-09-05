require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::RequestRepo do

# Initialize Method Tester
  it "Initializes the PuppyRequestContainer" do

    request_repo = PuppyBreeder::Repos::RequestRepo.new

    expect(request_repo.class).to eq(PuppyBreeder::Repos::RequestRepo)
    expect(request_repo.log.class).to eq(Array)

  end

# Add Request Method Tester
  it "Adds Purchase Request to the Purchase Request Container." do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("Golden Retriever")
    request3 = PuppyBreeder::Request.new("Boxer", "Approved")

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)

    expect(request_repo.log.length).to eq(3)
    expect(request_repo.log[2].class).to eq(PuppyBreeder::Request)
    # expect(request_repo.log[0]).to eq(request)
    expect(request_repo.log[1].breed).to eq("Golden Retriever")
    expect(request_repo.log[0].id).to eq(1)

  end

# Completed Requests Method Tester
  xit "Returns an array of all completed (approved or denied) requests" do 

    request_container = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("Golden Retriever")
    request3 = PuppyBreeder::Request.new("Golden Retriever")
    request4 = PuppyBreeder::Request.new("Golden Retriever")
    request5 = PuppyBreeder::Request.new("Golden Retriever")
    request6 = PuppyBreeder::Request.new("Golden Retriever")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    request_container.requests[1].approve!
    request_container.requests[2].deny!
    request_container.requests[3].approve!
    request_container.requests[4].deny!
    request_container.requests[5].approve!

    expect(request_container.completed_requests).to be_a(Array)
    expect(request_container.completed_requests).to eq([request2, request3, request4, request5, request6])
    expect(request_container.completed_requests.length).to eq(5)

  end

# Pending Requests Method Tester
  xit "Returns all pending requests" do

    request_container = PuppyBreeder::RequestRepo.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request5 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request6 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    request_container.requests[2].pending!
    request_container.requests[4].pending!
    request_container.requests[5].pending!

    expect(request_container.pending_requests.class).to eq(Array)
    expect(request_container.pending_requests).to eq([request3, request5, request6])
    expect(request_container.pending_requests.length).to eq(3)

  end

# Approved Requests Method Tester
  xit "Returns all approved requests" do

    request_container = PuppyBreeder::RequestRepo.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request5 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request6 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    request_container.requests[0].approve!
    request_container.requests[2].approve!
    request_container.requests[5].approve!

    expect(request_container.approved_requests.class).to eq(Array)
    expect(request_container.approved_requests).to eq([request, request3, request6])
    expect(request_container.approved_requests.length).to eq(3)

  end

# Denied Requests Method Tester
  xit "Returns all denied requests" do

    request_container = PuppyBreeder::RequestRepo.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request5 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request6 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    request_container.requests[1].deny!
    request_container.requests[4].deny!
    request_container.requests[5].deny!

    expect(request_container.denied_requests.class).to eq(Array)
    expect(request_container.denied_requests).to eq([request2, request5, request6])
    expect(request_container.denied_requests.length).to eq(3)

  end

# Held Requests Method Tester
  xit "Returns hold requests by order of request." do

    request_container = PuppyBreeder::RequestRepo.new

    request = PuppyBreeder::PurchaseRequest.new("French Bulldog")
    request2 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request3 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request4 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request5 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    request6 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

    request_container.add_request(request)
    request_container.add_request(request2)
    request_container.add_request(request3)
    request_container.add_request(request4)
    request_container.add_request(request5)
    request_container.add_request(request6)

    request_container.requests[1].deny!
    request_container.requests[4].deny!
    request_container.requests[5].deny!

    expect(request_container.held_requests).to eq([request, request3, request4])

  end  

# Requests by Breed Method Tester
  xit "Returns an array of all requests by breed." do

    request_container = PuppyBreeder::RequestRepo.new

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

  context "Method for database entry." do
    it "Returns all pending requests. Given the current database. Only French Bulldog will be pending" do 

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("Golden Retriever")
    request3 = PuppyBreeder::Request.new("Boxer", "Approved")

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)

    # expect(request_repo.show_requests).to eq([request_repo.log[0]])
# <!-- <br/> Amount: <%= request.cost %> -->
    end
  end

end