require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "allows customers to submit requests" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:Chow, mill, "Jo")

    expect(dawg.status).to eq "pending"
  end

  it "stores requests by breed in a hash in the Breeder class" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:Chow, mill, "Jo")

    expect(mill.purchase_requests[:Chow]).to eq [{requester: "Jo", status: "pending" }]
  end
end

describe PuppyBreeder::Breeder do
  it "enables Breeder class to submit purchase requests" do
    mill = PuppyBreeder::Breeder.new
    mill.submit_purchase_request(:Goldendoodle, "Nancy")
    
    expect(mill.purchase_requests[:Goldendoodle]).to eq [{requester: "Nancy", status: "pending" }]
  end
  end