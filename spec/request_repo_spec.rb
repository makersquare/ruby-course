require_relative 'spec_helper.rb'

describe PAWS::Repos::RequestRepo do

  before(:each) do
    PAWS.puppy_repo.build_tables
    PAWS.request_repo.build_tables
  end

  after(:each) do
    PAWS.puppy_repo.drop_table
    PAWS.request_repo.drop_table
  end

  it "can add a request" do
    @test_request = PAWS::Request.new("boxer")
    PAWS.request_repo.add_request(@test_request)
    test_answer = PAWS.request_repo.log
    expect(@test_request.breed).to eq(test_answer.first.breed)
  end

  it "can update a request" do
    @test_request = PAWS::Request.new("boxer")
    PAWS.request_repo.add_request(@test_request)
    @test_request.complete!
    PAWS.request_repo.update_request_status(@test_request)
    test_answer = PAWS.request_repo.log
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(test_answer.first.complete?).to be_true
    @test_request = PAWS::Request.new("schnauzer")
    PAWS.request_repo.add_request(@test_request)
    test_answer = PAWS.request_repo.log
    expect(test_answer[1].on_hold?).to be_true
  end

  it "can show requests for various statuses" do
    @test_request = PAWS::Request.new("boxer")
    PAWS.request_repo.add_request(@test_request)
    test_answer = PAWS.request_repo.show_on_hold_requests
    expect(@test_request.breed).to eq(test_answer.first.breed)
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(@test_request.id).to eq(test_answer.first.id)

    @test_request.complete!
    PAWS.request_repo.update_request_status(@test_request)
    test_answer = PAWS.request_repo.show_completed_requests
    expect(@test_request.breed).to eq(test_answer.first.breed)
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(@test_request.id).to eq(test_answer.first.id)
  end

end