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

	it "adds purchase requests to the array" do
		po_array = PuppyBreeder::PurchaseOrderArray.new

		expect(po_array.purchase_array).to eq([])
		
		po = PuppyBreeder::PurchaseRequest.new('boxer')
		po_array.add_purchase_request(po)

		expect(po_array.purchase_array.first).to eq(po)
	end
end