module PuppyBreeder
  class Request
    attr_reader :breed, :id, :cost, :status

# Initializes with breed, status, and id.
    def initialize(breed, status="Pending")
      @breed = breed
      @status = status # == "Pending", "Approved", "On Hold" or "Denied".
      @id = nil
      @cost = 1000
    end

# DENIED REQUESTS:

    def denied?
      @status == "Denied"
    end

    def denied!
      @status = "Denied"
    end

# PENDING REQUESTS:
    def pending?
      @status == "Pending"
    end

    def pending!
      @status = "Pending"
    end

# APPROVED REQUESTS: 

    def approved?
      @status == "Approved"
    end

    def approved!
      @status = "Approved"
    end

# HOLD REQUESTS:

    def on_hold?
      @status == "On Hold"
    end

    def on_hold!
      @status = "On Hold"
    end

  end
end    