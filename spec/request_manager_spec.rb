require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestManager do
  xit "allows Breeder to review pending requests" do
    mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill, "Jo", status = "completed")
    request2 = mill.submit_purchase_request(:Goldendoodle, "Nancy")
        # binding.pry
result = PuppyBreeder::RequestManager.see_pending_requests(mill)
    
    expect(request1.status).to eq ("completed")
    expect(result.count).to eq 1 
  end

  xit "allows Breeder to review completed requests" do
    mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill, status = "completed")
    request2 = mill.submit_purchase_request(:Goldendoodle)
    result = PuppyBreeder::RequestManager.see_completed_requests(mill)
    
    
    expect(result).to eq [request1]  
  end

  xit "allows Breeder to view completed transactions" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:chow, mill, "Jo")
    mill.submit_purchase_request(:Goldendoodle, "Nancy")
    
    expect( ).to eq  
  end
end

 