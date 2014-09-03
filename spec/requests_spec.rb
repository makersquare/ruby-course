require_relative 'spec_helper.rb'

describe PuppyBreeder::Requests do
  before(:each) { PuppyBreeder::Requests.instance_variable_set :@purchase_orders, [] }
  before(:each) { PuppyBreeder::ForSale.instance_variable_set :@for_sale, {} }

  describe '#new_request' do
    it "adds a new purchase request to the purchase orders array" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      result = PuppyBreeder::Requests.purchase_orders

      expect(result.size).to eq 2
      expect(result.first.breed).to eq("Golden Retriever")
    end

    it "checks if there is a puppy of the chosen breed available and marks as on_hold if not" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

      result = request1.status
      expect(result).to eq(:on_hold)
    end
  end

  describe '#complete_request' do
    it "changes the status of the accepted order to completed in the purchase orders array" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.accept

      result = PuppyBreeder::Requests.purchase_orders

      expect(result.first.status).to eq(:completed)
    end
  end

  describe '#pending_purchase_orders' do
    it "shows only purchase orders with a status of pending" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      spot.add
      fido.add
    
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.accept

      result = PuppyBreeder::Requests.pending_purchase_orders

      expect(result.size).to eq 1
      expect(result.first.status).to eq (:pending)
    end
  end

  describe '#completed_purchase_orders' do
    it "shows only purchase orders with a status of completed" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.accept

      result = PuppyBreeder::Requests.completed_purchase_orders

      expect(result.size).to eq 1
      expect(result.first.status).to eq (:completed)
    end
  end

  describe '#hold_to_pending' do
    it "changes the first on hold order for a particular breed to pending" do
      
    end
  end

end