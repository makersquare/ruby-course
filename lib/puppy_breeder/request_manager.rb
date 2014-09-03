#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  class RequestManager
    attr_accessor :pending


    def self.see_pending_requests(breeder)
      breeder.purchase_requests.select {|request| request.status == "pending"}
    end


    def self.see_completed_requests(breeder)
      breeder.purchase_requests.select {|request| request.status == "completed" } 
    end

    def self.accept_all_requests(breeder)
      breeder.purchase_requests.each {|request| request.status = "completed" }
    end
  end
end