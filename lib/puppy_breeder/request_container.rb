module PuppyBreeder

class RequestContainer

  attr_accessor :requests

@@requests = {}

  def self.requests
    @@requests
  end

  def self.save_request(purchaserequest)
    if @@requests.has_key?(purchaserequest.breed)
      @@requests[purchaserequest.breed] << purchaserequest
    else
      @@requests[purchaserequest.breed] = []
      @@requests[purchaserequest.breed] << purchaserequest
    end
  end

  def self.show_all_requests
    @@requests
  end

  def self.show_accepted_requests
    @@requests.select { |r| r.status == 'accepted' }
  end

  def self.show_hold_requests
    @@requests.select { |r| r.status == 'hold'}
  end

end
end