require_relative 'spec_helper.rb'

describe 'PuppyBreeder' do
  it "adds a new breed" do
    PuppyBreeder.add_breed("lab", 300)
    (PuppyBreeder::Data.cost).should include("lab" => 300)
  end

  it "reviews pending purchase requests" do
    PuppyBreeder.add_breed("lab", 300)
    request = PuppyBreeder::PurchaseRequest.new("Dan", "lab")
    result = PuppyBreeder.pending_requests
    (PuppyBreeder::Data.allrequests).should include(request)
    (result).should include(request)
  end

  it "reviews completed purchase requests" do
    PuppyBreeder.add_breed("lab", 300)
    request = PuppyBreeder::PurchaseRequest.new("Steve", "lab")
    PuppyBreeder.complete_request(request.id)
    result = PuppyBreeder.completed_requests
    (PuppyBreeder::Data.allrequests).should include(request)
    (result).should include(request)
  end

end