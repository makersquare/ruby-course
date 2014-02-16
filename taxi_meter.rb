class TaxiMeter
	attr_accessor :miles_driven
	attr_writer :amount_due
	attr_reader :start_time, :stop_time, :sixth, :time

	def initialize(airport: false)
		@airport = airport
		@miles_driven = 0
		@sixth = 1.0 / 6.0
		@first_sixth = 250
		@additional_sixth = 40
		@minute_rate = 2900.0 / 60.0
	end

	def start
		@start_time = Time.now
	end

	def stop
		@stop_time = Time.now
	end

	def time
		if @stop_time
			@stop_time
		else
			Time.now
		end
	end

	def amount_due
		fare = 0
		if @miles_driven == 0 
			fare
		else
			# Divide miles driven into sixths 
			# and remove the first sixth
			sixths_miles = (@miles_driven / @sixth).ceil - 1

			fare = @first_sixth + sixths_miles * @additional_sixth
		end

		if @start_time
		# Find how many minutes have passed
		clock = (time - @start_time) / 60

		fare += clock * @minute_rate
		end

		if @airport && fare < 1310
			fare = 1310
		else
			fare.ceil
		end
	end
end
