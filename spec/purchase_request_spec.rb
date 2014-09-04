require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::PurchaseRequest do
  #patrick wrote the following line to reset counter 
  before (:each) { PuppyBreeder::PurchaseRequest.class_variable_set(:@@counter, 0) }

  it "creates a purchase request instance" do
    new_request = PuppyBreeder::PurchaseRequest.new("Schnauzer")

    expect(new_request.class).to eq(PuppyBreeder::PurchaseRequest)
  end

  it "sets the status to pending" do
    new_request = PuppyBreeder::PurchaseRequest.new("Schnauzer")

    expect(new_request.status).to eq("pending")
  end

  it 'sets the breed' do
    new_request = PuppyBreeder::PurchaseRequest.new("Schnauzer")

    expect(new_request.breed).to eq("Schnauzer")
  end 

  it 'creates a sequential request id' do
    new_request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    new_request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")
    expect(new_request.request_id).to be(1)
    expect(new_request2.request_id).to be(2)
  end


end