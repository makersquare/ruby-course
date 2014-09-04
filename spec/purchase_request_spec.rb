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


  it "deleted the puppy object from the breeder class hash @breed_types because the other was accepted" do
    puppy1 = PuppyBreeder::PurchaseRequest.new("John", "pitbull", "email")
    step2 = PuppyBreeder::RequestContainer.save_request(puppy1)

    breeder1 = PuppyBreeder::Breeder.new("Ravi")
    pupp1 = PuppyBreeder::Puppy.new("Lucy", 23, "pitbull")
    breeder1.for_sale(pupp1)

    puppy1.hold
    puppy1.accept(breeder1)

    expect(puppy1.status).to eq("accepted")
    expect(breeder1.breed_types["pitbull"][:list][0]).to eq (nil)



  end
end

   
