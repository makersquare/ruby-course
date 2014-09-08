require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::PurchaseRequest do
  before do
    PuppyBreeder.request_repo.refresh_tables
    PuppyBreeder.puppy_repo.refresh_tables
  end

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


end