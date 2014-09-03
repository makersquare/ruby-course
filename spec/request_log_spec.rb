require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::RequestLog do

  it 'adds a request to the request log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    PuppyBreeder::RequestLog.add_request(request)

    expect(PuppyBreeder::RequestLog.request_log.first).to eq(request)

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

  it 'gives the completed orders in the log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    request2 = PuppyBreeder::PurchaseRequest.new("Maltese")
    log = PuppyBreeder::RequestLog.new
    log.add_request(request)
    log.modify_request(request.request_id, "approved")
    log.add_request(request)

    expect(log.view_completed).not_to include(request2)
    expect(log.view_completed).to include(request)
  end

  xit 'purges the log' do
    #erases the log and empties the array or maybe it just archives it 
    #so the current log gets pushed into a separate array with all the 
    #other archived logs, and the request log returns to an empty state. 
  end
end