require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestContainer do

  before(:each) { PuppyBreeder::RequestContainer.class_variable_set(:@@requests, {}) }

    it "use the save_request method and add into an array" do

      puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
      # binding.pry

      step2 = PuppyBreeder::RequestContainer.save_request(puppy1)
     
      puppy2 = PuppyBreeder::PurchaseRequest.new("Jamie", "pitbull", "telephone")
      step2 = PuppyBreeder::RequestContainer.save_request(puppy2)


      expect(PuppyBreeder::RequestContainer.requests[puppy1.breed][0].customer_name).to eq("John")
      expect(PuppyBreeder::RequestContainer.requests[puppy1.breed][0].breed).to eq("pitbull")
      expect(PuppyBreeder::RequestContainer.requests[puppy1.breed][0].received_by).to eq("email")
      expect(PuppyBreeder::RequestContainer.requests[puppy1.breed][0].status).to eq("pending")


      expect(PuppyBreeder::RequestContainer.requests[puppy2.breed][1].customer_name).to eq("Jamie")
      expect(PuppyBreeder::RequestContainer.requests[puppy2.breed][1].breed).to eq("pitbull")
      expect(PuppyBreeder::RequestContainer.requests[puppy2.breed][1].received_by).to eq("telephone")
      expect(PuppyBreeder::RequestContainer.requests[puppy2.breed][1].status).to eq("pending")

    end

    it "show all request" do
      puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
      PuppyBreeder::RequestContainer.save_request(puppy1)
      puppy2 = PuppyBreeder::PurchaseRequest.new("Jamie", "pitbull", "email")
      PuppyBreeder::RequestContainer.save_request(puppy2)
      step2 = PuppyBreeder::RequestContainer.show_all_requests
      
      expect(step2).to eq({"pitbull" =>[puppy1, puppy2]})
      
    end

  
end