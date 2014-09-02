require_relative 'spec_helper.rb'



describe PuppyBreeder::PurchaseRequest do
  it 'Creates a Puppy Request' do 
    a = PuppyBreeder::PurchaseRequest
    b = PuppyBreeder::PurchaseRequest.new('mix')
    expect(b.request_id).to eq(1)
    expect(b.breed).to eq('mix')
    expect(b.status).to eq(false)
    c = PuppyBreeder::PurchaseRequest.new('mix')
    expect(c.request_id).to eq(2)
  end
end


describe PuppyBreeder::RequestRepository do
  it 'Should allow request repo to create requests.' do
    a = PuppyBreeder::RequestRepository
    req1 = PuppyBreeder::RequestRepository.create_request('pitbull')
    expect(a.list.count).to eq(1)
    expect(a.breed_requested(1)).to eq('pitbull')
    req2 = PuppyBreeder::RequestRepository.create_request
    expect(a.list.count).to eq(2)
  end

  it 'Be ale to list pending requests.' do
    a = PuppyBreeder::RequestRepository
    req3 = PuppyBreeder::RequestRepository.create_request
    req4 = PuppyBreeder::RequestRepository.create_request
    expect(a.pending_list.count).to eq(4)
  end

  it 'Should requests to be filled.' do
    a = PuppyBreeder::RequestRepository
    STDOUT.should_receive(:puts).with("Request 1 has been filled.")
    STDOUT.should_receive(:puts).with("Request 2 has been filled.")
    a.complete_request(1)
    a.complete_request(2)
    expect(a.completed_list.count).to eq(2)
  end

  it 'Completed list should populate completed requests.' do
    a = PuppyBreeder::RequestRepository
    expect(a.completed_list.count).to eq(2)
  end


################################################################################
  it 'Pending List should populate when hold requested used.' do
    a = PuppyBreeder::RequestRepository
    req5 = a.create_request('pinata')
    req6 = a.create_request('pinata')
    a.hold_request(5)
    a.hold_request(6)
    expect(a.pending_requests.count).to eq(2)
  end


end


# breed_requested