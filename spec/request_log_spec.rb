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

  it 'adds a breed to the prices table' do
    PuppyBreeder.request_repo.add_breed("Schnauzer", 500)

binding.pry
    expect(PuppyBreeder.request_repo.get_price_list.first)
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

  it 'modifies a pending request' do
    #create a new purchase request - schnauzer - pending
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    #create a new puppy - dana - schnauzer
    puppy = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 30)
    #adds the puppy to the repo - 
    PuppyBreeder.puppy_repo.add_puppy(puppy)
    #adds the request to the repo - status pending
    PuppyBreeder.request_repo.add_request(request)
    #runs the check holds - 
      #gets the list of hold requests as array of objects
        # and stores it in holds variable
      #gets the list of puppies available and stores it in 
        # avail_puppies
      #iterates through each hold - checking each puppy against 
        #the hold breed to find a match
      #if a match is found - it retrieves the id of the puppy and
        #the id of the request and passes those to a new method called
      #update records
        #updates the request in the database with the puppy id and
          #accepted
        #updates the puppy in the database to change availability
    PuppyBreeder.request_repo.update_records(puppy.id, request.id)
    #binding.pry
    #stores the array of accepted request objects in accepted
    accepted = PuppyBreeder.request_repo.show_accepted_requests
  #expect the first object in the array of accepted requests to have
  #an id of the id generated
    expect(accepted.last.id).to eq(1)  
    #create a puppy
    #create a request
    #add the puppy to the inventory
    #add the request to the request log

    #find the pending request and store the id. 
    #approve the request

    #expect - show approved requests - the last request's id should be
    # #the same as the id of the request we just approved
    # request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    # log = PuppyBreeder.request_repo #sets the log variable t
    # log.add_request(request)
    # log.modify_request(request.id, "approved")

    # expect(log.request_log.last.status).to eq("approved")
  end

  it 'adds the oldest purchase request to request log when a puppy matching the request is added' do
    
    #add request for a dinosaur puppy
    request = PuppyBreeder::PurchaseRequest.new("Dinosaur")
    #should add the request but because there's no dinosaur in the table
    #it should mark it as category hold. 
    PuppyBreeder.request_repo.add_request(request)
    #a puppy is created
    #gets the id for the puppy in the 
    puppy = PuppyBreeder::Puppy.new("Rex", "Dinosaur", 1)

    #puppy is added
    PuppyBreeder.puppy_repo.add_puppy(puppy)
    #method adds the puppy to the repo and calls request_repo update hold
    #which checks for any holds that can be fulfilled and then fulfills them

    expect(PuppyBreeder.request_repo.show_accepted_requests.last.puppy_id).to eq(1)
  end

  it 'gives the completed orders in the log' do
    puppy = PuppyBreeder::Puppy.new("Dana", "Schnauzer", 3)
    PuppyBreeder.puppy_repo.add_puppy(puppy)
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    request2 = PuppyBreeder::PurchaseRequest.new("Maltese")
    PuppyBreeder.request_repo.add_request(request)
    PuppyBreeder.request_repo.add_request(request2)
    PuppyBreeder.request_repo.update_records(puppy.id, request.id)
    log = PuppyBreeder.request_repo
    expect(log.show_accepted_requests.length).to eq(1)
    expect(PuppyBreeder.request_repo.show_accepted_requests.first.id).to eq(1)
  end

end