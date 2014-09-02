require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

   describe '.initialize' do

    it "accept purchase request" do

      breeder1 = PuppyBreeder::PurchaseRequest.new("Ravi", "American Eskimo", "Email")
      accepted = breeder1.accept

      expect(accepted.breeder.purchase_history[0].customer_name).to eq("Ravi")
      expect(accepted.breeder.purchase_history[0].breed).to eq("American Eskimo")
      expect(accepted.breeder.purchase_history[0].received_by).to eq("Email")


    end

  end

end