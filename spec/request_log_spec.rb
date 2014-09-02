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

  xit 'gives the first pending request for approval' do
    #sort through the request log array for pending status
    #get the first one
    #approves or rejects 
    #changes the status of the request
  end

  xit 'gives a list of all requests in the log' do
    #returns the request log array
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