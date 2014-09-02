#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  class RequestManager

    attr_reader :open_reqests, :completed_requests, :denied_requests

    @@open_requests = []
    @@denied_requests = []
    @@completed_requests = []

    #do I need initialize?
    def initialize()
    end

    def self.add_request(purchase_request)
      open_requests.push(purchase_request)
    end

    def self.approve_request(purchase_request)
      open_requests.delete(purchase_request)
      completed_requests.push(purchase_request)
    end

    def self.deny_request(purchase_request)
      open_requests.delete(purchase_request)
      denied_requests.push(purchase_request)
    end

    def self.view_open_requests()
      open_requests
    end

    def self.view_completed_requests()
      completed_requests
    end

    def self.view_denied_requests()
      denied_requests
    end

    

    
  end
end