require_relative 'spec_helper.rb'

describe PAWS::Repos::PuppyRepo do

  before(:each) do
    @test_puppy = PAWS::Puppy.new("boxer","Rex",30)
    PAWS.puppy_repo.build_tables
    PAWS.request_repo.build_tables
  end

  after(:each) do
    PAWS.puppy_repo.drop_table
    PAWS.request_repo.drop_table
  end

  it "can add a puppy" do
    PAWS.puppy_repo.add_puppy(@test_puppy)
    test_answer = PAWS.puppy_repo.log
    expect(@test_puppy.breed).to eq(test_answer.first.breed)
  end

  it "can add a puppy and match it to a request" do
    @test_request = PAWS::Request.new("boxer")
    PAWS.request_repo.add_request(@test_request)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    test_answer = PAWS.puppy_repo.log
    expect(test_answer.first.status.to_sym).to eq(:adopted)
  end

  it "can show all breeds" do
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy = PAWS::Puppy.new("pug","Spot",30)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    result = PAWS.puppy_repo.show_all_breeds
    expect(result).to eq(["boxer","pug"])
  end

  it "can show all available breeds" do
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy = PAWS::Puppy.new("pug","Spot",30)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    result = PAWS.puppy_repo.show_available_breeds
    expect(result).to eq(["boxer","pug"])
  end

  it "can show all available puppies" do
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy1 = PAWS::Puppy.new("pug","Spot",30)
    PAWS.puppy_repo.add_puppy(@test_puppy1)
    result = PAWS.puppy_repo.show_all_available_puppies
    result = result.map { | x | x.name }
    expect(result).to eq([@test_puppy.name,@test_puppy1.name])
  end

  it "can perform an adoptathon!" do
    @test_puppy = PAWS::Puppy.new("pug","Spot",1)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy = PAWS::Puppy.new("pug","Rex",2)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy = PAWS::Puppy.new("boxer","King",3)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    @test_puppy = PAWS::Puppy.new("schnauzer","Hell",4)
    PAWS.puppy_repo.add_puppy(@test_puppy)
    
    @test_request = PAWS::Request.new("boxer")
    PAWS.request_repo.add_request(@test_request)
    @test_request = PAWS::Request.new("pug")
    PAWS.request_repo.add_request(@test_request)
    @test_request = PAWS::Request.new("schnauzer")
    PAWS.request_repo.add_request(@test_request)
    @test_request = PAWS::Request.new("alien")
    PAWS.request_repo.add_request(@test_request)

    result = PAWS.request_repo.show_pending_requests
    expect(result.map {|x| x.breed}).to eq(["boxer","pug","schnauzer"])

    PAWS.puppy_repo.adoptathon
    
    result = PAWS.puppy_repo.show_all_available_puppies
    expect(result.first.name).to eq("Rex")

    result = PAWS.puppy_repo.show_all_adopted_puppies
    expect(result.map {|x| x.breed}).to eq(["boxer","pug","schnauzer"])

    result = PAWS.request_repo.show_completed_requests
    expect(result.map {|x| x.breed }).to eq(["boxer","pug","schnauzer"])

    result = PAWS.request_repo.show_on_hold_requests
    expect(result.first.breed).to eq("alien")
  end

end

