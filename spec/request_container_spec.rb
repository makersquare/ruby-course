require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestContainer do

  before(:each) { PuppyBreeder::RequestContainer.class_variable_set(:@@requests, []) }

    it "use the save_request method" do

      puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
      step2 = PuppyBreeder::RequestContainer.save_request(puppy1)
      
      expect(PuppyBreeder::RequestContainer.requests[0].customer_name).to eq("John")
      expect(PuppyBreeder::RequestContainer.requests[0].breed).to eq("pitbull")
      expect(PuppyBreeder::RequestContainer.requests[0].received_by).to eq("email")
      expect(PuppyBreeder::RequestContainer.requests[0].status).to eq("pending")

    end

    it "show all the requests" do
      puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
      PuppyBreeder::RequestContainer.save_request(puppy1)
      puppy2 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
      PuppyBreeder::RequestContainer.save_request(puppy2)
      step2 = PuppyBreeder::RequestContainer.show_all_requests
      
      expect(step2).to eq([puppy1, puppy2])
      

    end
end