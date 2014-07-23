class Request

  attr_reader :breed, :cust_phone_number, :status

  def initialize(arg)
    @breed = arg[:breed]
    @cust_phone_number = arg[:cust_phone_number]
    @status = arg[:status]||:pending
    @time = Time.now
  end

  def status_to_pending
    @status = :pending
  end

  def status_to_accepted
    @status = :accepted
  end

  def status_to_hold
    @status = :hold
  end

end