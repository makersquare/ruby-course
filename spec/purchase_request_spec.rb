require_relative 'spec_helper.rb'

describe 'PuppyBreeder::PurchaseRequest' do
  
  it "allows a customer to submit a purchase request for a specific breed for review by breeder" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    john = PuppyBreeder::PurchaseRequest.new('John')
    john.request_dog('mut', travis)
    expect(travis.purchase_requests[john]).to eq(benson)
  end


  it "allows the breeder to a sell a dog to a customer with a pending purchase request" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    john = PuppyBreeder::PurchaseRequest.new('John Smith')
    john.request_dog('mut', travis)
    travis.sell_dog(benson)

    expect(benson.status).to eq 'sold to John Smith'
    expect(travis.bank_account).to eq(50)
  end

  it "allows the breeder to view all puppy sales" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    molly = PuppyBreeder::Puppy.new('Molly', "black lab", 2)
    travis.new_puppy(molly)
    john = PuppyBreeder::PurchaseRequest.new('John Smith')
    john.request_dog('mut', travis)
    travis.sell_dog(benson)

    expect(travis.view_sales.first).to eq(benson)
  end

end
