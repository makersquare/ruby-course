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

			expect(po.breed).to eq('boxer')
			expect(po.status).to eq('pending')
		end
	end
end

describe PuppyBreeder::Repos::PurchaseOrderArray do
	before(:all) do
		PuppyBreeder.request_repo.drop_table
	end
	it "exists" do
		expect(PuppyBreeder::Repos::PurchaseOrderArray).to be_a(Class)
	end

	describe ".initialize" do
		xit "adds purchase requests to the array" do
			po_array = PuppyBreeder::Repos::PurchaseOrderArray.new
			PuppyBreeder.request_repo
			expect(po_array.purchase_array).to eq([])
		end
	end
		
	describe ".add_purchase_request" do
		xit "puts the purchase request in the array" do
			po_array = PuppyBreeder::Repos::PurchaseOrderArray.new
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po_array.add_purchase_request(po)

			expect(po_array.purchase_array.first).to eq(po)
		end
	end

	describe ".review_new_orders" do
		it "returns an array with purchase requests with status pending" do
			# po_array = PuppyBreeder::Repos::PurchaseOrderArray.new
			po1 = PuppyBreeder::PurchaseRequest.new('boxer')
			po2 = PuppyBreeder::PurchaseRequest.new('fox')
			PuppyBreeder.request_repo.add_purchase_request(po1)
			PuppyBreeder.request_repo.add_purchase_request(po2)
			result = PuppyBreeder.request_repo.review_new_orders

			expect(result[0].status).to eq("pending")
			expect(result[1].status).to eq("pending")
		end
	end

	describe ".change_status" do
		xit "changes the status of the purchase request in the array" do
			po_array = PuppyBreeder::PurchaseOrderArray.new
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po_array.add_purchase_request(po)
			po_array.change_status(po, 'completed')

			expect(po_array.purchase_array.first.status).to eq('completed')
		end
	end

	describe ".review_orders_on_hold" do
		xit "returns an array with purchase requests with status hold" do
			po_array = PuppyBreeder::PurchaseOrderArray.new
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po_array.add_purchase_request(po)
			po_array.change_status(po, 'hold')

			expect(po_array.review_orders_on_hold).to eq([po])
		end
	end

	describe ".review_all_orders_not_on_hold" do
		xit "returns an array of all purchase orders not on hold" do
			po_array = PuppyBreeder::PurchaseOrderArray.new
			po1 = PuppyBreeder::PurchaseRequest.new('boxer')
			po2 = PuppyBreeder::PurchaseRequest.new('fox')
			po_array.add_purchase_request(po1)
			po_array.add_purchase_request(po2)
			po_array.add_purchase_request(po1)
			po_array.change_status(po1, 'hold')

			expect(po_array.review_all_orders_not_on_hold).to eq([po2])
		end
	end

	describe ".review_completed_orders" do
		xit "returns an array with purchase requests with status completed" do
			po_array = PuppyBreeder::PurchaseOrderArray.new
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po_array.add_purchase_request(po)
			po_array.change_status(po, 'completed')

			expect(po_array.review_completed_orders).to eq([po])
		end
	end
end


# describe PuppyBreeder::Repo::Inventory do
# 	xit "exists" do
# 		expect(PuppyBreeder::Inventory).to be_a(Class)
# 	end

# 	describe ".initialize" do
# 		xit "creates empty hash inventory_hash in inventory class" do
# 			inv = PuppyBreeder::Inventory.new
			
# 			expect(inv.inventory_hash).to eq({})
# 		end
# 	end

# 	describe ".add_breed_price" do
# 		xit "adds to the breed price hash with the breed as the key and price as the value" do
# 			inv = PuppyBreeder::Inventory.new
# 			inv.add_breed_price("boxer", 2.99)

# 			expect(inv.inventory_hash.first).to eq(["boxer", {:price => 2.99, :puppies => []}])
# 		end
# 	end

# 	describe ".add_puppy_to_inventory" do
# 		xit "adds an instance of a puppy into the inventory hash" do
# 			pup = PuppyBreeder::Puppy.new('doggy', 'boxer', 30)
# 			inv = PuppyBreeder::Inventory.new
# 			inv.add_breed_price("boxer", 2.99)
# 			inv.add_puppy_to_inventory(pup)

# 			expect(inv.inventory_hash[pup.breed][:puppies]).to eq([pup])
# 		end
#		end
# end