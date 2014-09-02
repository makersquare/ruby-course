module PuppyBreeder

class RequestContainer
  @@requests = []
  def self.save_request(request)
    @@requests << request
  end

  def self.show_all_requests
    @@requests
  end

  def self.show_accepted_requests
    @@requests.select { |r| r.status == 'accepted' }
  end
end

end