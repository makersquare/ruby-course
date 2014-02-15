require 'time'

class TaxiMeter
	attr_accessor :miles_driven
	attr_accessor :start_time
	attr_accessor :stop_time
	attr_accessor :airport

  def initialize
  	@amount_due = 0
  	@miles_driven = 0
  	@airport = false
    @waiting_cost = @waiting_cost
    @mileage_cost = @mileage_cost
  end

  def one_sixth
    1.0 / 6.0
  end

  def start
  	@start_time = Time.now
  end

  def stop
  	@stop_time = Time.now
  end
  
  def amount_due
	  #calc miles driven cost
    if @miles_driven <= one_sixth && @miles_driven > 0
	  	@mileage_cost = 2.5
	  elsif @miles_driven > one_sixth
			@mileage_cost = 2.10 + 0.4 * (@miles_driven * 6).ceil
		else
	  	@mileage_cost = 0	
  	end
      
    #calcs waiting time
    if @stop_time 
      puts @stop_time
      @waiting_time = @stop_time - @start_time
    else
      @waiting_time = Time.now - @start_time
    end
    #calcs waiting_cost
    if @waiting_time
      @waiting_cost = (@waiting_time/60) * (29.0/60)
    else
      @waiting_cost = 0
    end

    if airport
      airport = 13.10
    else 
      airport = 0
    end

    return @amount_due = (@mileage_cost * 100).round(0) + (@waiting_cost * 100).round(0) + (airport * 100)


  end

  def amount_due=(value)
  	@amount_due = value
  end
 
end
