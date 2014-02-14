class TaxiMeter
 
  attr_reader :amount_due, :miles_driven, :start_time, :stop_time
  
  def initialize(airport:false)
  	@amount_due = 0
  	@miles_driven = 0
  	@airport = false
  	@start_time = nil
  	@stop_time = nil
  end

  def start
  	 @start_time = Time.now
  end

  def stop
  	@stop_time = Time.now
  end

end
