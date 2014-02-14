class TaxiMeter
	attr_accessor :miles_driven
	attr_reader :start_time, :stop_time, :sixth

	def initialize(airport: false)
		@airport = airport
		@miles_driven = 0
		@sixth = 1.0 / 6.0
		@first_sixth = 250
		@additional_sixth = 40
	end

	def start
		@start_time = Time.now
	end

	def stop
		@stop_time = Time.now
	end

	def amount_due
		if @miles_driven == 0
			0
		else
			# Divide miles driven into sixths 
			# and remove the first sixth
			sixths_miles = (@miles_driven / @sixth).ceil - 1

			fare = @first_sixth + sixths_miles * @additional_sixth

			if @airport && fare < 1310
				fare = 1310
			else
				fare
			end
		end
	end
end
