require "./puppy-breeder.rb"
require 'pry-byebug'

describe Puppy do

  describe 'create Puppy' do

    it "creates a new instance of Puppy" do
      expect {new_puppy = Puppy.new('Fry', 'boxer', 20)}.to_not raise_error
    end

    it "check for puppy attributes" do
      new_puppy = Puppy.new('Fry', 'boxer', 20)
      expect(new_puppy.name).to eq("Fry")
      expect(new_puppy.breed).to eq(:boxer)
      expect(new_puppy.age).to eq(20)
    end

  end

end


describe PuppyInv do

  describe 'create new puppy inventory' do
    it 'create puppy inventory' do
      expect {justins_farm = PuppyInv.new}.to_not raise_error
    end
  end

  describe 'check functionality of justins farm' do
    before(:all) do
      @justins_farm = PuppyInv
    end

    it 'check if a puppy can be added to inventory' do
      @justins_farm.add_puppy_to_inventory('Sam', 'lab', 20)
      @justins_farm.add_puppy_to_inventory('Buddy', 'lab', 22)
      @justins_farm.add_puppy_to_inventory('Spot', 'retriever', 15)
      @justins_farm.add_puppy_to_inventory('Mars', 'retriever', 16)
      expect(@justins_farm.inventory[:lab][:list].first.name).to eq("Sam")
    end

    it 'sets the price for a breed' do
      expect {@justins_farm.set_breed_price('lab', 500)}.to_not raise_error
      expect {@justins_farm.set_breed_price('retriever', 1500)}.to_not raise_error
    end

    it 'check the price of a breed' do
      price = @justins_farm.check_price('lab')
      expect(price).to eq(500)
    end
  end

describe Request do

  describe 'create Request' do

    it "creates a new purchase order" do
      expect {new_PO = Request.new('Bobby', 'boxer')}.to_not raise_error
    end

    it "check for puppy attributes" do
      new_PO = Request.new('Bobby', 'boxer')
      expect(new_PO.customer).to eq("Bobby")
      expect(new_PO.breed).to eq(:boxer)
      expect(new_PO.status).to eq(:pending)
    end

    it "check for set status attribute" do
      new_PO2 = Request.new('Maya', 'dachshund')
      justins_farm = PuppyInv.new
      new_PO2.check_availability('dachshund')
      expect(new_PO2.status).to eq(:onhold)
      # expect(new_PO2.status).to eq(:onhold)
    end
    
      end
    it 'check if a Request can be added to reqlist' do
     bobby = Request.new('Bobby', 'lab')
      expect(bobby.show_reqlist[0].customer).to eq("Bobby")
      end
  end
end


