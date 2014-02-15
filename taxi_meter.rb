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
 	total = @amount_due
 	if @stop_time
 		if @miles_driven == 0
 			total = ((@stop_time - @start_time)*29.0/36).round(0)
		elsif @miles_driven < 1.0/6.0
 			total = ((@stop_time - @start_time)*29.0/36).round(0) + 250
 		else 
 			total = ((@stop_time - @start_time)*29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 		end 
 	else 
 		if @miles_driven === 0
 			total = ((Time.now - @start_time)*29.0/36).round(0)
 		elsif @miles_driven < 1.0/6
 			total = ((Time.now - @start_time)* 29.0/36).round(0) + 250
 		else
 			total = ((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 		end
 	end
 end
end
