require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::RequestLog do
  it 'creates a new inventory' do
    test = PuppyBreeder::RequestLog.new

    expect(test.class).to eq(PuppyBreeder::RequestLog)
  end
  it 'adds a request to the request log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog.new
    log.add_request(request)

    expect(log.request_log.first).to eq(request)

  end

  it 'gets pending requests' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog.new
    log.add_request(request)

    expect(log.review_pending.first.status).to eq("pending")    
  end

  it 'modifies a pending request' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog.new
    log.add_request(request)
    log.modify_request(request.request_id, "approved")

    expect(log.request_log.first.status).to eq("approved")
  end


  xit 'gives a list of all requests in the log' do
    #returns the request log array
  end

  xit 'gives the completed orders in the log' do
    #returns completed
  end

  xit 'gives the rejected requests from the log' do
    #returns the rejected status requests
  end

  xit 'purges the log' do
    #erases the log and empties the array or maybe it just archives it 
    #so the current log gets pushed into a separate array with all the 
    #other archived logs, and the request log returns to an empty state. 
  end
end