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

  it 'adds the oldest purchase request to request log when a puppy matching the request is added' do
    PuppyBreeder::RequestLog.class_variable_set :@@request_log, []
    PuppyBreeder::RequestLog.class_variable_set :@@hold_log, []
    
    request = PuppyBreeder::PurchaseRequest.new("Dinosaur")
    PuppyBreeder::RequestLog.add_request(request)
    puppy = PuppyBreeder::Puppy.new("Rex", "Dinosaur", 1)
    PuppyBreeder::Inventory.add_puppy(puppy)

    expect(PuppyBreeder::RequestLog.request_log).to include(request)
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