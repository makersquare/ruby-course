require_relative 'spec_helper.rb'

describe 'PuppyBreeder' do
  it "adds a new breed" do
    PuppyBreeder.add_breed("lab", 300)
    (PuppyBreeder::Data.cost).should include("lab" => 300)
  end

  it "reviews pending purchase requests" do
    PuppyBreeder.add_breed("lab", 300)
    request = PuppyBreeder::PurchaseRequest.new("Dan", "lab")
    result = PuppyBreeder.pending_requests
    (PuppyBreeder::Data.allrequests).should include(request)
    (result).should include(request)
  end

  it "can complete a request" do
    PuppyBreeder.add_breed("lab", 300)
    dog = PuppyBreeder::Puppy.new('kevin', 'lab')
    request = PuppyBreeder::PurchaseRequest.new("Jack", "lab")
    PuppyBreeder.complete_request(request.id)
    expect(dog.status).to eq('adopted')
    expect(request.status).to eq('completed')
    expect(request.puppy).to eq(dog)
  end

  it "reviews completed purchase requests" do
    PuppyBreeder.add_breed("lab", 300)
    dog = PuppyBreeder::Puppy.new('fido', 'lab')
    request = PuppyBreeder::PurchaseRequest.new("Steve", "lab")
    PuppyBreeder.complete_request(request.id)
    result = PuppyBreeder.completed_requests
    (PuppyBreeder::Data.allrequests).should include(request)
    (result).should include(request)
  end

  it "runs the dog_available? method" do
    dog = PuppyBreeder::Puppy.new('spike', 'lab')
    result = PuppyBreeder.dog_available?('lab')
    expect(result).to eq(true)
  end

  it "runs the dog_available? method with no dog available" do
    result = PuppyBreeder.dog_available?('pitbull')
    expect(result).to eq(false)
  end

  it "puts a request on hold if there is no puppy" do
    PuppyBreeder.add_breed("lab", 300)
    request = PuppyBreeder::PurchaseRequest.new("Steve", "retriever")
    PuppyBreeder.complete_request(request.id)
    expect(request.status).to eq('hold')
  end

  it "removes a hold from a request" do
    request = PuppyBreeder::PurchaseRequest.new("Steve", "terrier")
    PuppyBreeder.complete_request(request.id)
    expect(request.status).to eq('hold')
  end

end