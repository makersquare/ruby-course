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
  end

  def one_sixth
    1.0 / 6.0
  end

  def start
  	@start_time = Time.now
  end

  def stop
  	@stop_time = Time.now
  	if @stop_time 
      @waiting_time = @stop_time - @start_time
    else
      @waiting_time = Time.now - @start_time
    end
  end
  
  def amount_due
	  #calc miles driven cost
    if @miles_driven <= one_sixth
	  	@amount_due = 2.5
	  elsif @miles_driven > one_sixth
			@amount_due = 2.10 + 0.4 * (@miles_driven * 6).ceil
		else
	  	@amount_due = 0	
  	end
      
    #cals time waiting cost
    if @waiting_time
      waiting_cost = (@waiting_time * 60) + (29.0/60)
    end

    return (@amount_due * 100).round(0)

  end

  def amount_due=(value)
  	@amount_due = value
  end
 
end
