require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::Repos::RequestLog do

  before do
    PuppyBreeder.request_repo.refresh_tables
    PuppyBreeder.puppy_repo.refresh_tables
  end

  it 'adds a request to the database' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    PuppyBreeder.request_repo.add_request(request)

    expect(PuppyBreeder.request_repo.log.first.breed).to eq("Schnauzer")


  end

  it 'sets the status of the request to hold if no matching pup is available' do
    request = PuppyBreeder::PurchaseRequest.new("Dinosaur")
    PuppyBreeder.request_repo.add_request(request)

    expect(PuppyBreeder.request_repo.show_holds.first.status).to eq("hold")
  end

  it 'gets pending requests' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    puppy = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 30)
    PuppyBreeder.puppy_repo.add_puppy(puppy)
    PuppyBreeder.request_repo.add_request(request)

    expect(PuppyBreeder.request_repo.log.first.status).to eq("pending")    
  end

  xit 'modifies a pending request' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog
    #binding.pry
    log.add_request(request)
    log.modify_request(request.request_id, "approved")

    expect(log.request_log.last.status).to eq("approved")
  end

  xit 'adds the oldest purchase request to request log when a puppy matching the request is added' do
    PuppyBreeder::RequestLog.class_variable_set :@@request_log, []
    PuppyBreeder::RequestLog.class_variable_set :@@hold_log, []
    
    request = PuppyBreeder::PurchaseRequest.new("Dinosaur")
    PuppyBreeder::RequestLog.add_request(request)
    puppy = PuppyBreeder::Puppy.new("Rex", "Dinosaur", 1)
    PuppyBreeder::Inventory.add_puppy(puppy)

    expect(PuppyBreeder::RequestLog.request_log).to include(request)
  end

  xit 'gives the completed orders in the log' do
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