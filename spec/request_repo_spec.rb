require_relative 'spec_helper.rb'

describe PAWS::Repos::RequestRepo do

  before(:each) do
    @test_table = PAWS::Repos::RequestRepo.new
    @test_dumb = PAWS::Repos::PuppyRepo.new
  end

  after(:each) do
    @test_table.drop_table
    @test_dumb.drop_table
  end

  it "can add a request" do
    @test_request = PAWS::Request.new("boxer")
    @test_table.add_request(@test_request)
    test_answer = @test_table.log
    expect(@test_request.breed).to eq(test_answer.first.breed)
  end

  it "can update a request" do
    @test_request = PAWS::Request.new("boxer")
    @test_table.add_request(@test_request)
    @test_request.complete!
    @test_table.update_request_status(@test_request)
    test_answer = @test_table.log
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(test_answer.first.complete?).to be_true

    @test_table.update_request_status_by_db_id(:on_hold,1)
    test_answer = @test_table.log
    expect(test_answer.first.on_hold?).to be_true
  end

  it "can show requests for various statuses" do
    @test_request = PAWS::Request.new("pug")
    @test_table.add_request(@test_request)
    test_answer = @test_table.show_on_hold_requests
    expect(@test_request.breed).to eq(test_answer.first.breed)
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(@test_request.id).to eq(test_answer.first.id)

    @test_request.complete!
    @test_table.update_request_status(@test_request)
    test_answer = @test_table.show_completed_requests
    expect(@test_request.breed).to eq(test_answer.first.breed)
    expect(@test_request.status).to eq(test_answer.first.status)
    expect(@test_request.id).to eq(test_answer.first.id)
  end

end