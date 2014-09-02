#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  class RequestManager
    attr_accessor :pending


    # def self.see_pending_requests(breeder)
    #   breeder.purchase_requests.select do |key, array|
        
    # end

    # def self.approve_requests(breeder)
    #   self.see_pending_requests(breeder)
    # end

    def self.see_completed_requests(breeder)
      breeder.purchase_requests.each do |key, array|
        @completed = array.select do |request| 
           request.status == "completed" 
        end
      end 
      return @completed   
    end


  end
end