require_relative 'spec_helper.rb'

describe PAWS::Repos::BreedRepo do

  before(:each) do
  end

  after(:each) do
    PAWS.breed_repo.drop_table
  end

  it "can add a breed by hand" do
    test_answer = PAWS.breed_repo.add_breed_by_hand("boxer",100)
    expect(test_answer).to eq({"breed"=>"boxer", "price"=>"$100.00"})
  end

  it "can change a breed price by hand" do
    PAWS.breed_repo.add_breed_by_hand("boxer",100)
    test_answer = PAWS.breed_repo.change_breed_price_by_hand("boxer",500)
    expect(test_answer).to eq({"breed"=>"boxer", "price"=>"$500.00"})
  end

  it "can get a price" do
    PAWS.breed_repo.add_breed_by_hand("boxer",100)
    test_answer = PAWS.breed_repo.get_price("boxer")
    expect(test_answer).to eq("$100.00")
  end

  it "will not allow a double entry for a breed" do
    test_answer = PAWS.breed_repo.add_breed_by_hand("boxer",100)
    $stdout.should_receive(:puts).with("That breed already exists.")
    PAWS.breed_repo.add_breed_by_hand("boxer",500)
    test_answer = PAWS.breed_repo.get_price("boxer")
    expect(test_answer).to eq("$100.00")
  end

end