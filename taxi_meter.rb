require 'time'

class TaxiMeter
	attr_accessor :miles_driven
	attr_accessor :start_time
	attr_accessor :stop_time
	attr_accessor :airport
  attr_writer :amount_due

  def initialize(airport: false)
  	@amount_due = 0
  	@miles_driven = 0
  	@airport = airport
    @total_cost = 0
    
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

    #calc total cost
    @total_cost = (@mileage_cost * 100).round(0) + (@waiting_cost * 100).round(0)
    #calcs drunk tax
    if (@start_time >= Time.parse("9 PM")) || (@start_time < Time.parse("4 AM"))
      @total_cost += 100
    end
    
    #calcs airport
    if (@total_cost < 13.10) && (@airport == true)
      @total_cost = (13.10 * 100)
    end

    #set amount_due to total cost
    @amount_due = @total_cost

    return @amount_due

  end

 
end
