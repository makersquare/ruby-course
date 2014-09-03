require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "allows customers to submit requests" do
    mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill)
    result = mill.purchase_requests[:chow]

    expect(request1.status).to eq "pending"
    expect(result).to eq [request1]
  end

  it "stores requests by breed in a hash in the Breeder class" do
   mill = PuppyBreeder::Breeder.new
    request1 = PuppyBreeder::PurchaseRequest.new(:chow, mill)
    result = mill.purchase_requests[:chow]

    expect(result).to eq [request1]
  end
end

describe PuppyBreeder::Breeder do
  it "enables Breeder class to submit purchase requests" do
    mill = PuppyBreeder::Breeder.new
    result = mill.submit_purchase_request(:Goldendoodle)

    expect(mill.purchase_requests[:Goldendoodle]).to eq [result]
  end
end