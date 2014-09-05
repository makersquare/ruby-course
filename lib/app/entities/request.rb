module PAWS
  
  class Request
  
    attr_reader :breed, :status, :id
  
    def initialize(breed, status=:pending, id=nil)
      @breed = breed
      @status = status
      @id = id
    end
  
    def pending?
      @status == :pending
    end

    def complete?
      @status == :complete
    end
    
    def complete!
      @status = :complete
    end

    def on_hold?
      @status == :on_hold
    end
    
    def on_hold!
      @status = :on_hold
    end

    def id=(x)
      @id = x
    end

  end

end