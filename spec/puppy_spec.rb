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

	# describe ".initialize" do
	# 	xit "creates a connection" do
	# 		PuppyBreeder.request_repo
	# 		expect().to be_a()
	# 	end
	# end
		
	describe ".add_purchase_request" do
		it "puts the purchase request in the table" do
			PuppyBreeder.request_repo.drop_table
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			PuppyBreeder.request_repo.add_purchase_request(po)
			result = PuppyBreeder.request_repo.review_new_orders

			expect(result.first.breed).to eq('boxer')
			expect(po.id).to eq(1)
		end
	end

	describe ".review_new_orders" do
		it "returns an array with purchase requests with status pending" do
			# po_array = PuppyBreeder::Repos::PurchaseOrderArray.new
			PuppyBreeder.request_repo.drop_table
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
		it "changes the status of the purchase request in the array" do
			PuppyBreeder.request_repo.drop_table
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			PuppyBreeder.request_repo.add_purchase_request(po)
			PuppyBreeder.request_repo.change_status(po, 'hold')
			result = PuppyBreeder.request_repo.review_orders_on_hold

			expect(result.first.status).to eq('hold')
		end
	end

	describe ".review_orders_on_hold" do
		it "returns an array with purchase requests with status hold" do
			PuppyBreeder.request_repo.drop_table
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po2 = PuppyBreeder::PurchaseRequest.new('dog')
			PuppyBreeder.request_repo.add_purchase_request(po)
			PuppyBreeder.request_repo.add_purchase_request(po2)
			PuppyBreeder.request_repo.change_status(po, 'hold')
			PuppyBreeder.request_repo.change_status(po2, 'hold')
			result = PuppyBreeder.request_repo.review_orders_on_hold

			expect(result.first.status).to eq('hold')
			expect(result.last.status).to eq('hold')
		end
	end

	describe ".review_all_orders_not_on_hold" do
		it "returns an array of all purchase orders not on hold" do
			PuppyBreeder.request_repo.drop_table
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			po2 = PuppyBreeder::PurchaseRequest.new('fox')
			PuppyBreeder.request_repo.add_purchase_request(po)
			PuppyBreeder.request_repo.add_purchase_request(po2)
			PuppyBreeder.request_repo.change_status(po2, 'hold')
			result = PuppyBreeder.request_repo.review_all_orders_not_on_hold

			expect(result.first.status).to eq('pending')
		end
	end

	describe ".review_completed_orders" do
		it "returns an array with purchase requests with status completed" do
			PuppyBreeder.request_repo.drop_table
			po = PuppyBreeder::PurchaseRequest.new('boxer')
			PuppyBreeder.request_repo.add_purchase_request(po)
			PuppyBreeder.request_repo.change_status(po, 'completed')
			result = PuppyBreeder.request_repo.review_completed_orders

			expect(result.first.status).to eq('completed')
		end
	end
end


describe PuppyBreeder::Repos::Inventory do
	it "exists" do
		expect(PuppyBreeder::Repos::Inventory).to be_a(Class)
	end

	# describe ".initialize" do
	# 	xit "creates empty hash inventory_hash in inventory class" do
	# 		inv = PuppyBreeder::Inventory.new
			
	# 		expect(inv.inventory_hash).to eq({})
	# 	end
	# end

	# describe ".add_breed_price" do
	# 	xit "adds to the breed price hash with the breed as the key and price as the value" do
	# 		inv = PuppyBreeder::Inventory.new
	# 		inv.add_breed_price("boxer", 2.99)

	# 		expect(inv.inventory_hash.first).to eq(["boxer", {:price => 2.99, :puppies => []}])
	# 	end
	# end

	describe ".add_puppy_to_inventory" do
		it "adds an instance of a puppy into the database" do
			PuppyBreeder.inventory_repo.drop_table
			pup = PuppyBreeder::Puppy.new('doggy', 'boxer', 30)
			PuppyBreeder.inventory_repo.add_puppy_to_inventory(pup)
			result = PuppyBreeder.inventory_repo.review_puppies

			expect(result.first.breed).to eq('boxer')
		end
	end
end