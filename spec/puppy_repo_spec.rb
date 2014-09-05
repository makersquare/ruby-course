require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Puppies do
  before(:each) {PuppyBreeder.puppy_repo.destroy}
  before(:each) {PuppyBreeder.request_repo.destroy}

  describe '.add_puppy' do
    it "can add puppies for sale" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      puppies = PuppyBreeder::Repos::Puppies.new
      puppies.add_puppy(spot)
      result = puppies.log

      expect(result.size).to eq 1
      expect(result.first.age.to_i).to eq 1
      expect(result.first.breed).to eq "Golden Retriever"

      puppies.add_puppy(fido)
      result = puppies.log

      expect(result.size).to eq 2
      expect(result.last.age.to_i).to eq 2
      expect(result.last.breed).to eq "Pitbull"
      expect(result.any?{|x| x.breed == "Boston Terrier"}).to be_false
    end

  end

  # describe '#purchase' do
  #   it "removes puppies from the for sale group once purchased" do
  #     spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
  #     fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      
  #     spot.add(500)
  #     fido.add(800)

  #     order = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
  #     result = order.accept
      
  #     expect(result["Golden Retriever"][:count]).to eq(0)
  #     expect(result["Pitbull"][:count]).to eq(1)
  #   end 
  # end

end