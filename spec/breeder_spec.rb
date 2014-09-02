require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do

  describe '.initialize' do

    it "creates a new breeder class" do

      breeder1 = PuppyBreeder::Breeder.new("Ravi")
    
      expect(breeder1.name).to eq("Ravi")
      

    end

    it "it makes a puppy be fore sale" do

    breeder1 = PuppyBreeder::Breeder.new("Ravi")
    
    request = breeder1.purchase_request("John", "American Eskimo", "Email")

    expect(request.class).to eq(PuppyBreeder::PurchaseRequest)
    expect(request.customer_name).to eq("John")
    expect(request.breed).to eq("American Eskimo")
    expect(request.received_by).to eq("Email")

    end



  end

end
