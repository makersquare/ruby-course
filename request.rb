class Request

  attr_reader :breed, :cust_phone_number

  def initialize(arg)
    @breed = arg[:breed]
    @cust_phone_number = arg[:cust_phone_number]
  end

end