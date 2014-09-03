require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestManager do
  it "allows Breeder to review pending requests" do
    mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill)
    request2 = PuppyBreeder::PurchaseRequest.new(:chow, mill, "completed")
     result = PuppyBreeder::RequestManager.see_pending_requests(mill)
    
    expect(request2.status).to eq ("completed")
    expect(result.count).to eq 1 
  end

  it "allows Breeder to review completed requests" do
    mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill, "completed")
    request2 = mill.submit_purchase_request(:Goldendoodle)
    result = PuppyBreeder::RequestManager.see_completed_requests(mill)
    
    
    expect(result).to eq [request1]  
  end


  it "allows Breeder to accept all puppy requests" do
     mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill)
    request2 = mill.submit_purchase_request(:Goldendoodle)
    PuppyBreeder::RequestManager.accept_all_requests(mill)
    result = PuppyBreeder::RequestManager.see_completed_requests(mill)
    expect(result.count).to eq 2
  end
end

 