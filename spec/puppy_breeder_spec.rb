require_relative 'spec_helper.rb'

describe PuppyBreeder do

before(:all) do
    @pup1 = PuppyBreeder.add_puppy(PuppyBreeder::Puppy.new(breed: "boxer",name:"Nick",age_in_days:30))
    @pup2 = PuppyBreeder.add_puppy(PuppyBreeder::Puppy.new(breed: "pug",name:"Ben",age_in_days:30))
    @pup3 = PuppyBreeder.add_puppy(PuppyBreeder::Puppy.new(breed: "pug",name:"Spot",age_in_days:30))
end

  it "can make a hash of puppies" do
    test = PuppyBreeder.dogs_available
    expect(test).to be_a(Hash)
  end
  
  it "the hash is organized by breed" do
    test = PuppyBreeder.dogs_available
    expect(test[:pug][:dog_list].count).to eq(2)
  end

  it "can accept a purchase request" do
    test_request = PuppyBreeder::PurchaseRequest.new("James","boxer")
    PuppyBreeder.review_purchase(test_request)
    expect(PuppyBreeder.open_purchase_requests[0].customer).to eq("James")
    expect(PuppyBreeder.open_purchase_requests[0].breed).to eq("boxer")
  end

  it "can reject a purchase request if that breed isn't available" do
    test_request = PuppyBreeder::PurchaseRequest.new("Rick","schnoodle")
    answer = PuppyBreeder.review_purchase(test_request)
    expect(answer).to eq("Your purchase request can not be filled at this time.")
  end

  it "can deliver a puppy and complete a request" do
    test_request = PuppyBreeder::PurchaseRequest.new("Darrel","pug")
    PuppyBreeder.review_purchase(test_request)
    test_puppy = PuppyBreeder.deliver_puppy(test_request)
    test = PuppyBreeder.dogs_available
    expect(test[:pug][:dog_list].count).to eq(1)
    expect(test_puppy.breed).to eq("pug")
  end
end