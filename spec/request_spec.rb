require_relative 'spec_helper.rb'

describe PAWS::Request do
  it "creates a purchase request with a breed, status, id" do
    test_request = PAWS::Request.new("boxer")
    expect(test_request).to be_a(PAWS::Request)
    expect(test_request.status).to eq(:pending)
    expect(test_request.breed).to eq("boxer")
    expect(test_request.id).to eq(nil)
  end

  it "can tell and update the status" do
    test_request = PAWS::Request.new("boxer")

    expect(test_request.pending?).to be_true
    expect(test_request.complete?).to be_false
    expect(test_request.on_hold?).to be_false
    
    test_request.complete!
    expect(test_request.complete?).to be_true
    expect(test_request.pending?).to be_false
    expect(test_request.on_hold?).to be_false

    test_request.on_hold!
    expect(test_request.on_hold?).to be_true
    expect(test_request.pending?).to be_false
    expect(test_request.complete?).to be_false
  end

end