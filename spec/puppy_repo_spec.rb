require_relative 'spec_helper.rb'

describe PAWS::Repos::PuppyRepo do

  before(:each) do
    @test_table = PAWS::Repos::PuppyRepo.new
    @test_dumb = PAWS::Repos::RequestRepo.new
    @test_puppy = PAWS::Puppy.new("boxer","Rex",30)
  end

  after(:each) do
    @test_table.drop_table
    @test_dumb.drop_table
  end

  it "can add a puppy" do
    @test_table.add_puppy(@test_puppy,@test_dumb)
    test_answer = @test_table.log
    expect(@test_puppy.breed).to eq(test_answer.first.breed)
  end

  it "can add a puppy and match it to a request" do
    @test_request = PAWS::Request.new("boxer")
    @test_dumb.add_request(@test_request)
    @test_table.add_puppy(@test_puppy,@test_dumb)
    test_answer = @test_table.log
    expect(test_answer.first.status.to_sym).to eq(:adopted)
  end

  it "can show all breeds" do
    @test_table.add_puppy(@test_puppy,@test_dumb)
    @test_puppy = PAWS::Puppy.new("pug","Spot",30)
    @test_table.add_puppy(@test_puppy,@test_dumb)
    result = @test_table.show_all_breeds
    expect(result).to eq(["boxer","pug"])
  end

  it "can show all available breeds" do
    @test_table.add_puppy(@test_puppy,@test_dumb)
    @test_puppy = PAWS::Puppy.new("pug","Spot",30)
    @test_table.add_puppy(@test_puppy,@test_dumb)
    result = @test_table.show_available_breeds
    expect(result).to eq(["boxer","pug"])
  end

  it "can show all available puppies" do
    @test_table.add_puppy(@test_puppy,@test_dumb)
    @test_puppy1 = PAWS::Puppy.new("pug","Spot",30)
    @test_table.add_puppy(@test_puppy1,@test_dumb)
    result = @test_table.show_all_available_puppies
    result = result.map { | x | x.name }
    expect(result).to eq([@test_puppy.name,@test_puppy1.name])
  end

end