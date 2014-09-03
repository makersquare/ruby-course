require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestManager do
  xit "allows Breeder to review pending requests" do
    mill = PuppyBreeder::Breeder.new
    mill.add_breed(:chow, 1500)
    pup1 = PuppyBreeder::Puppy.new("Spot", :chow, 1)
    pup2 = PuppyBreeder::Puppy.new("Josh", :chow, 2)
    mill.add_inventory(pup1)
    mill.add_inventory(pup2)
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill)
    request2 = PuppyBreeder::PurchaseRequest.new(:chow, mill, status = "completed")
     
result = PuppyBreeder::RequestManager.see_pending_requests(mill)
    
    expect(request2.status).to eq ("completed")
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

 