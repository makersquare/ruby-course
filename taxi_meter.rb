class TaxiMeter
	attr_accessor :amount_due, :miles_driven
	attr_reader :start_time, :stop_time

	def start
		@start_time = Time.now
	end

	def stop
		@stop_time = Time.now
	end

end
