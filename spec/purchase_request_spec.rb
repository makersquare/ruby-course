require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "creates a purchase request" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(PuppyBreeder::PurchaseRequest.purchase_orders.first).to eq(result)
  end

  it "creates purchase request for german shepherds" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.breed).to eq("german shepherd")
  end
end