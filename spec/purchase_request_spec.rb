require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do

    it "initialize purchase request" do

      puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
    
      expect(puppy1.customer_name).to eq("John")
      expect(puppy1.breed).to eq("pitbull")
      expect(puppy1.received_by).to eq("email")  
      expect(puppy1.status).to eq("pending")

    end


   it "change status to hold" do

    puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
    puppy1.hold
  
    expect(puppy1.status).to eq("hold")
    end

end

   
