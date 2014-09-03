require_relative 'spec_helper.rb'

describe PuppyBreeder::ForSale do
  before(:each) { PuppyBreeder::ForSale.instance_variable_set :@for_sale, {} }

  describe '#add' do
    it "can add puppies for sale" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      
      spot.add
      result = PuppyBreeder::ForSale.for_sale

      expect(result.size).to eq 1
      expect(result[spot.breed][:count]).to eq 1
      expect(result[spot.breed][:price]).to be_nil

      result2 = fido.add(800)

      expect(result.size).to eq 2
      expect(result[fido.breed][:count]).to eq 1
      expect(result[fido.breed][:price]).to eq 800
      expect(result["Boston Terrier"]).to be_nil
    end

  end

  describe '#purchase' do
    it "removes puppies from the for sale group once purchased" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      
      spot.add(500)
      fido.add(800)

      order = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      result = order.accept
      
      expect(result["Golden Retriever"][:count]).to eq(0)
      expect(result["Pitbull"][:count]).to eq(1)
    end 
  end

end