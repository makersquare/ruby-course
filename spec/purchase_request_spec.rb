require_relative 'spec_helper.rb'

describe 'PuppyBreeder::PurchaseRequest' do
  
  it "allows a customer to submit a purchase request for a specific breed for review by breeder. If dog is not available, the request is put on hold" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    john = PuppyBreeder::PurchaseRequest.new('John')
    mike = PuppyBreeder::PurchaseRequest.new('Mike')
    john.request_dog('mut', travis)
    travis.update_price('black lab', 100)

    expect(travis.puppies.first.buyer).to eq(john)
    expect(travis.hold['mut'].first).to eq(nil)

    john.request_dog('mut', travis)
    mike.request_dog('mut', travis)

    expect(travis.hold['mut'][0]).to eq([0,john])
    expect(travis.hold['mut'][1]).to eq([1,mike])
    abby = PuppyBreeder::Puppy.new("Abby", "mut", 2)
    travis.new_puppy(abby)
    expect(travis.hold['mut'].length).to eq(1)
    expect(travis.hold['mut'][0]).to eq([1, mike])
    expect(abby.status).to eq('pending purchase by John')
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
    expect(benson.buyer.name).to eq('John Smith')
  end

  it "allows the breeder to view all puppy sales" do
    benson = PuppyBreeder::Puppy.new("Benson", "mut", 5)
    travis = PuppyBreeder::Breeder.new('Travis')
    travis.new_puppy(benson)
    travis.update_price('black lab', 100)
    molly = PuppyBreeder::Puppy.new('Molly', "black lab", 2)
    travis.new_puppy(molly)
    john = PuppyBreeder::PurchaseRequest.new('John Smith')
    john.request_dog('mut', travis)
    travis.sell_dog(benson)


    expect(travis.view_sales.first).to eq(benson)
    expect(travis.view_sales.length).to eq(1)
  end
end
