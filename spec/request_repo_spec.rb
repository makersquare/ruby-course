require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::RequestRepo do

# Initialize Method Tester
  it "Initializes the RequestRepo" do

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
    expect(request_repo.log[1].breed).to eq("Golden Retriever")
    expect(request_repo.log[0].id).to eq(1)

  end

# Completed Requests Method Tester
  it "Returns an array of all completed (approved or denied) requests" do 

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_completed_requests).to be_a(Array)
    expect(request_repo.show_completed_requests.length).to eq(3)

  end

# Current Requests Method Tester
  it "Returns all current requests (pending or on hold)" do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_current_requests).to be_a(Array)
    expect(request_repo.show_current_requests.length).to eq(3)

  end

# Pending Requests Method Tester
  it "Returns all pending requests" do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_pending_requests).to be_a(Array)
    expect(request_repo.show_pending_requests.length).to eq(2)

  end

# Approved Requests Method Tester
  it "Returns all approved requests" do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_completed_requests).to be_a(Array)
    expect(request_repo.show_completed_requests.length).to eq(3)

  end

# Denied Requests Method Tester
  it "Returns all denied requests" do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_denied_requests).to be_a(Array)
    expect(request_repo.show_denied_requests.length).to eq(1)

  end

# Held Requests Method Tester
  it "Returns hold requests by order of request." do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("French Bulldog")
    request3 = PuppyBreeder::Request.new("French Bulldog")
    request4 = PuppyBreeder::Request.new("French Bulldog")
    request5 = PuppyBreeder::Request.new("French Bulldog")
    request6 = PuppyBreeder::Request.new("French Bulldog")

    request.approved!
    request2.denied!
    request4.on_hold!
    request6.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)
    request_repo.add_request(request6)

    expect(request_repo.show_hold_requests).to be_a(Array)
    expect(request_repo.show_hold_requests.length).to eq(1)

  end  

# Requests by Breed Method Tester
  it "Returns an array of all requests by breed." do

    request_repo = PuppyBreeder::Repos::RequestRepo.new
    request_repo.drop_and_rebuild_tables

    request = PuppyBreeder::Request.new("French Bulldog")
    request2 = PuppyBreeder::Request.new("Golden Retriever")
    request3 = PuppyBreeder::Request.new("Boxer")
    request4 = PuppyBreeder::Request.new("Boxer")
    request5 = PuppyBreeder::Request.new("French Bulldog")

    request3.approved!

    request_repo.add_request(request)
    request_repo.add_request(request2)
    request_repo.add_request(request3)
    request_repo.add_request(request4)
    request_repo.add_request(request5)

    expect(request_repo.current_requests_of_a_breed("French Bulldog").class).to eq(Array)
    expect(request_repo.current_requests_of_a_breed("French Bulldog").length).to eq(2)

    expect(request_repo.current_requests_of_a_breed("Golden Retriever").class).to eq(Array)
    expect(request_repo.current_requests_of_a_breed("Golden Retriever").length).to eq(1)

    expect(request_repo.current_requests_of_a_breed("Boxer").class).to eq(Array)
    expect(request_repo.current_requests_of_a_breed("Boxer").length).to eq(1)

  end

end