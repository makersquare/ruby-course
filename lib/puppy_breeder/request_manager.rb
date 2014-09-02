#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  class RequestManager
    attr_accessor :pending


    def self.see_pending_requests(breeder)
      @pending = []
      breeder.purchase_requests.each do |key, array|
        array.each do |requests| 
          if requests.status == "pending" 
            @pending << requests
          end
        end
      end 
      @pendings   
    end

    def self.approve_requests(breeder)
    end

    def self.view_completed_requests(breeder)
      breeder.purchase_requests.each do |key, array|
        @completed = array.select {|requests| requests.status == "completed" }
      end 
      @completed 
    end


  end
end