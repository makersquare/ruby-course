class TaxiMeter
  # TODO
  attr_accessor :amount_due, :miles_driven, :minutes, :stop, :stop_time, :start_time
  def initialize(amount_due=0, miles_driven=0, stop_time = nil)
  	@amount_due
  	@miles_driven
  	@stop
  end

  def start
  	@start_time = Time.now
  end

  def stop
  	@stop_time = Time.now
  end

 def amount_due
 end

end
