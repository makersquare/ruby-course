require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  it "creates a purchase request" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.class).to eq(PuppyBreeder::PurchaseRequest)
  end

  it "creates purchase request for german shepherds" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.breed).to eq("german shepherd")
  end

  it "checks that status is pending" do
    result = PuppyBreeder::PurchaseRequest.new("german shepherd")
    expect(result.status).to eq("pending")
  end
end

describe PuppyBreeder::Breeder do
  it "adds puppy to hash of puppies" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)

    expect(breeder.all_puppies[puppy.breed][:list].last.name).to eq("molly")
  end

  it "adds two puppies and checks that both are present" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    puppy1 = PuppyBreeder::Puppy.new("joe","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)
    breeder.add_puppy(puppy1)

    expect(breeder.all_puppies[puppy.breed][:list].first.name).to eq("molly")
    expect(breeder.all_puppies[puppy.breed][:list].last.name).to eq("joe")
  end

  it "checks that price is set to nil" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)

    expect(breeder.all_puppies[puppy.breed][:price]).to be(nil)
  end

  it "sets the price to the designated price" do
    puppy = PuppyBreeder::Puppy.new("molly","german shepherd",21)
    breeder = PuppyBreeder::Breeder.new("Joe-Shmoe")

    breeder.add_puppy(puppy)
    breeder.set_price("german shepherd","1000")

    expect(breeder.all_puppies[puppy.breed][:price]).to eq("1000")
  end
end