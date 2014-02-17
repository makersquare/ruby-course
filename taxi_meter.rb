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
  hour = @start_time.hour
 	if @stop_time
		if @miles_driven <= 1.0/6.0
			if @airport
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
  				if ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100 < 1310
  					total = 1310
  				else 
  					total = ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100
  				end
  			else 
          if ((@stop_time - @start_time)*29.0/36).round(0) + 250 < 1310
            total = 1310
          else 
   				 total = ((@stop_time - @start_time)*29.0/36).round(0) + 250
          end
   			end
      else 
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
          total = ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100
        else 
          total = ((@stop_time - @start_time)*29.0/36).round(0) + 250
        end
      end
 		else 
 			if @airport
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
   				if (((@stop_time - @start_time)*29.0/36).round(0) + ((@miles_driven*6.0).ceil * 40 + 210) + 100) < 1310
   					total = 1310
   				else 
   					total = (((@stop_time - @start_time)*29.0/36).round(0) + ((@miles_driven*6.0).ceil * 40 + 210) + 100)
   				end
        else
          if ((@stop_time - @start_time)*29.0/36).round(0) + 250 < 1310
            total = 1310
          else 
            total = (((@stop_time - @start_time)*29.0/36).round(0) + ((@miles_driven*6.0).ceil * 40 + 210))
          end
        end
 			else
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
          total = ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100
        else
 				 total = (((@stop_time - @start_time)*29.0/36).round(0) + ((@miles_driven*6.0).ceil * 40 + 210))
        end
 			end
 		end 
 	else 
 		if @miles_driven <= 1.0/6
 			if @airport
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
 				 if ((Time.now - @start_time)* 29.0/36).round(0) + 250 + 100 < 1310
 					total = 1310
 				 else 
 					total = ((Time.now - @start_time)* 29.0/36).round(0) + 250 + 100
 				 end
        else 
          total = ((Time.now - @start_time)* 29.0/36).round(0) + 250
        end
 			else 
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
        total = ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100
        else
 				 total = ((Time.now - @start_time)* 29.0/36).round(0) + 250
        end
 			end
 		else
 			if @airport
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
 				 if (((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven*6.0).ceil * 40 + 210 + 100) < 1310
 					total = 1310
 				 else 
 					total = (((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven*6.0).ceil* 40 + 210 + 100)
 				 end
 			  else 
 				 total = (((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven*6.0).ceil * 40 + 210)
        end
      else 
        if ((@start_time.hour <= 4) || (@start_time.hour >= 21))
          total = ((@stop_time - @start_time)*29.0/36).round(0) + 250 + 100
        else
          total = (((Time.now - @start_time)* 29.0/36).round(0) + (@miles_driven*6.0).ceil * 40 + 210)
        end
 			end
 		end
 	end
 end
end
