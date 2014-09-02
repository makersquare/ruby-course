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
    req1 = PuppyBreeder::RequestRepository.add_request
    expect(a.list.count).to eq(1)
    req2 = PuppyBreeder::RequestRepository.add_request
    expect(a.list.count).to eq(2)
  end

  it 'Be ale to list pending requests.' do
    a = PuppyBreeder::RequestRepository
    req3 = PuppyBreeder::RequestRepository.add_request
    req4 = PuppyBreeder::RequestRepository.add_request
    expect(a.pending_list.count).to eq(4)
  end

  it 'Should requests to be filled.' do
    a = PuppyBreeder::RequestRepository
    STDOUT.should_receive(:puts).with("Request 3 has been filled.")
    STDOUT.should_receive(:puts).with("Request 4 has been filled.")
    a.complete_request(1)
    a.complete_request(2)
    expect(a.completed_list.count).to eq(2)
  end

  it 'Completed list should populate completed requests.' do
    a = PuppyBreeder::RequestRepository
    expect(a.completed_list.count).to eq(2)

  end

end