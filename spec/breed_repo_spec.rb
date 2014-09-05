require_relative 'spec_helper.rb'

describe PAWS::Repos::PuppyRepo do

  before(:each) do
    @test_table = PAWS::Repos::BreedRepo.new
  end

  after(:each) do
    @test_table.drop_table
  end

  it "can add a breed" do
    test_answer = @test_table.add_breed("boxer",100)
    expect(test_answer).to eq({"breed"=>"boxer", "price"=>"$100.00"})
  end

  it "can change a breed price" do
    @test_table.add_breed("boxer",100)
    test_answer = @test_table.change_breed_price("boxer",500)
    expect(test_answer).to eq({"breed"=>"boxer", "price"=>"$500.00"})
  end

  it "can get a price" do
    @test_table.add_breed("boxer",100)
    test_answer = @test_table.get_price("boxer")
    expect(test_answer).to eq("$100.00")
  end

  it "will not allow a double entry for a breed" do
    test_answer = @test_table.add_breed("boxer",100)
    test_answer1 = @test_table.add_breed("boxer",500)
    test_answer = @test_table.get_price("boxer")
    expect(test_answer).to eq("$100.00")
  end

end