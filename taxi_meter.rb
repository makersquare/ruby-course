require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time, :airport

  def initialize(airport: false)
  	@amount_due = 0
  	@miles_driven = 0
  	@start_time = 0
  	@stop_time = nil
  	@airport = airport
  end

  def start
  	@start_time = Time.now
  	@stop_time
  	if (airport == true) 
  		amount_due = 13.10
  	else
  		@amount_due = 2.50
  	end
  end

  def stop
  	@stop_time = Time.now
  end

  def total_cost
  	@nine = Time.parse("9:00pm")
  	@four = Time.parse("4:00am")
  	@amount_due += ((miles_driven * 0.40) + (@time_diff * 0.483))
  	if @start_time >= @nine || @start_time <= @four
  		@amount_due += 1.00
  	end
  	@amount_due
  end

  def miles_traveled(num)
  	@miles_driven = num * 6.0
  end

  def waiting_time(time)
  	@stop_time = stop
  	@new_time = @stop_time + (time * 60)
  	@time_diff = (@new_time - @start_time) / 60
  end
end

taxi = TaxiMeter.new
puts taxi.start
puts taxi.miles_traveled(11.5)
puts taxi.stop
puts taxi.waiting_time(90)
puts taxi.total_cost
