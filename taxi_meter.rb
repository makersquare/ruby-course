require 'pry-debugger'
class TaxiMeter
  # TODO
  attr_accessor :amount_due, :miles_driven, :minutes, :stop, :stop_time, :start_time, :airport
  def initialize(amount_due=0, miles_driven=0, stop_time = nil, airport: false)
  	@amount_due
  	@miles_driven
  	@stop
  	@airport = airport
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
 			if @airport
 				if ((@stop_time - @start_time)*29.0/36).round(0) < 1310
 					total = 1310
 				else 
 					total = ((@stop_time - @start_time)*29.0/36).round(0)
 				end
 			else 
 				total = ((@stop_time - @start_time)*29.0/36).round(0)
 			end
		elsif @miles_driven < 1.0/6.0
			if @airport
				if ((@stop_time - @start_time)*29.0/36).round(0) + 250 < 1310
					total = 1310
				else 
					total = ((@stop_time - @start_time)*29.0/36).round(0) + 250
				end
			else 
 				total = ((@stop_time - @start_time)*29.0/36).round(0) + 250
 			end
 		else 
 			if @airport
 				if (((@stop_time - @start_time)*29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)) < 1310
 					total = 1310
 				else 
 					total = ((@stop_time - @start_time)*29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 				end
 			else
 				total = ((@stop_time - @start_time)*29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 			end
 		end 
 	else 
 		if @miles_driven === 0
 			if @airport
 				if ((Time.now - @start_time)*29.0/36).round(0) < 1310
 					total = 1310
 				else
 					total = ((Time.now - @start_time)*29.0/36).round(0)
 				end
 			else 
 				total = ((Time.now - @start_time)*29.0/36).round(0)
 			end
 		elsif @miles_driven < 1.0/6
 			if @airport
 				if ((Time.now - @start_time)* 29.0/36).round(0) + 250 < 1310
 					total = 1310
 				else 
 					total = ((Time.now - @start_time)* 29.0/36).round(0) + 250
 				end
 			else 
 				total = ((Time.now - @start_time)* 29.0/36).round(0) + 250
 			end
 		else
 			if @airport
 				if (((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)) < 1310
 					total = 1310
 				else 
 					total = ((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 				end
 			else 
 				total = ((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven * 6 * 40 + 210).round(2)
 			end
 		end
 	end
 end
end
