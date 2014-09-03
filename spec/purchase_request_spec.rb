require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "instantiates a new Purchase Request with customer name, breed, id, and status" do
    PuppyBreeder.add_breed("lab", 300)
    result = PuppyBreeder::PurchaseRequest.new("Dan", "lab")
    expect(result.class).to eq(PuppyBreeder::PurchaseRequest)
    expect(result.customer).to eq("Dan")
    expect(result.breed).to eq("lab")
    expect(result.price).to eq(300)
    expect(result.id).to eq(1)
    expect(result.status).to eq("pending")
  end


end