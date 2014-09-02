require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	it "exists" do
    expect(PuppyBreeder::Puppy).to be_a(Class)
  end

  describe ".initialize" do
  	it "creates and records attributes for the puppy" do
  		pup = PuppyBreeder::Puppy.new('doggy', 'boxer', 30)
  		
  		expect(pup.name).to eq('doggy')
  		expect(pup.breed).to eq('boxer')
  		expect(pup.age).to eq(30)
  		expect(pup.status).to eq('available')
  	end
  end
end

describe PuppyBreeder::PurchaseRequest do
	it "exists" do
		expect(PuppyBreeder::PurchaseRequest).to be_a(Class)
	end

	describe ".initialize" do
		it "creates a purchase request and records attributes for the request" do
			po = PuppyBreeder::PurchaseRequest.new('boxer')

			expect(po.breed_request).to eq('boxer')
			expect(po.status).to eq('pending')
		end
	end
end

describe PuppyBreeder::PurchaseOrderArray do
	it "exists" do
		expect(PuppyBreeder::PurchaseOrderArray).to be_a(Class)
	end

	describe ".initialize" do
		it "adds purchase requests to the array" do
			po_array = PuppyBreeder::PurchaseOrderArray.new

			expect(po_array.purchase_array).to eq([])
		end
	end
		
	describe ".add_purchase_request" do
		it "puts the purchase request in the array" do
			po_array = PuppyBreeder::PurchaseOrderArray.new
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po_array.add_purchase_request(po)

			expect(po_array.purchase_array.first).to eq(po)
		end
	end
end


describe PuppyBreeder::Inventory do
	it "exists" do
		expect(PuppyBreeder::Inventory).to be_a(Class)
	end

	describe ".initialize" do
		it "creates empty hash inventory_hash in inventory class" do
			inv = PuppyBreeder::Inventory.new
			
			expect(inv.inventory_hash).to eq({})
		end
	end

	describe ".add_breed_price" do
		it "adds to the breed price hash with the breed as the key and price as the value" do
			inv = PuppyBreeder::Inventory.new
			inv.add_breed_price("boxer", 2.99)

			expect(inv.inventory_hash.first).to eq(["boxer", {:price => 2.99, :puppies => []}])
		end
	end
end