class TaxiMeter
  # TODO
  attr_reader :start
  attr_accessor :amount_due, :miles_driven, :minutes, :stop, :stop_time
  def initialize(amount_due=0, miles_driven=0, stop_time = nil, stop = false)
  	@amount_due
  	@miles_driven
  	@stop
  end

  def start
  	Time.now
  end

  def start_time
  	Time.now
  end

  def stop
  	@stop = true
  end

  def stop_time
  	if @stop == true
  		@stop_time = Time.now
  	else 
  		@stop_time = nil
  	end
  end

end
