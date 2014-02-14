require 'time'

class TaxiMeter
	attr_accessor :amount_due
	attr_accessor :miles_driven
	attr_accessor :start_time
	attr_accessor :stop_time

  def initialize
  	@amount_due = 0
  	@miles_driven = 0
  end

  def start
  	@start_time = Time.now
  end

  def stop
  	time = Time.now
  	@stop_time = time + (5 * 60)
  end
end
