class TaxiMeter
  # TODO
  attr_accessor :amount_due, :miles_driven, :minutes, :stop, :stop_time, :start_time, :airport
  def initialize(amount_due=0, miles_driven=0, stop_time = nil, airport: false)
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
 	# if total_units < 1.0/6
 	# 	250
 	# else
 	# 	(210 + (40 * total_units)).round(2)
 	# end
 	if @miles_driven < 1.0/6
 		250
 	else 
 		(@miles_driven * 6 * 40 + 210).round(2)
 	end
 end

end
