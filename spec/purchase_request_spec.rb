require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "initializes with breed and initializes status as available" do

  po = PuppyBreeder::PurchaseRequest.new("husky")
  expect(po.breed).to eq("husky")
  expect(po.status).to eq("pending")
  end
end
