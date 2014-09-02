require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "allows customers to submit requests" do
    mill = PuppyBreeder::Breeder.new
    dawg = PuppyBreeder::PurchaseRequest.new(:Chow, mill, "Jo")

    expect(dawg.status).to eq "pending"
  end
end