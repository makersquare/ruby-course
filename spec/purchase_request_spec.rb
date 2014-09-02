require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "allows customers to submit requests" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:chow, mill, "Jo")

    expect(dawg.status).to eq "pending"
  end

  it "stores requests by breed in a hash in the Breeder class" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:chow, mill, "Jo")

    expect(mill.purchase_requests[:chow]).to eq [dawg]
  end
end

describe PuppyBreeder::Breeder do
  it "enables Breeder class to submit purchase requests" do
    mill = PuppyBreeder::Breeder.new
    result = mill.submit_purchase_request(:Goldendoodle, "Nancy")

    expect(mill.purchase_requests[:Goldendoodle]).to eq [result]
  end
end