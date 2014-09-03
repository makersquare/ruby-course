require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::RequestLog do

  it 'adds a request to the request log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    PuppyBreeder::RequestLog.add_request(request)

    expect(PuppyBreeder::RequestLog.request_log.first).to eq(request)

  end

  it 'adds a request to the hold log if there is no available pup' do
    request = PuppyBreeder::PurchaseRequest.new("Dinosaur")
    PuppyBreeder::RequestLog.add_request(request)

    expect(PuppyBreeder::RequestLog.hold_log.last).to eq(request)
  end

  it 'gets pending requests' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog
    log.add_request(request)

    expect(log.review_pending.first.status).to eq("pending")    
  end

  it 'modifies a pending request' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog
    #binding.pry
    log.add_request(request)
    log.modify_request(request.request_id, "approved")

    expect(log.request_log.last.status).to eq("approved")
  end

  it 'gives the completed orders in the log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    request2 = PuppyBreeder::PurchaseRequest.new("Maltese")
    log = PuppyBreeder::RequestLog
    log.add_request(request)
    log.modify_request(request.request_id, "approved")
    log.add_request(request)

    expect(log.view_completed).not_to include(request2)
    expect(log.view_completed).to include(request)
  end

end