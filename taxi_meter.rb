class TaxiMeter
	attr_accessor :miles_driven
	attr_reader :start_time, :stop_time, :sixth

	def initialize
		@miles_driven = 0
		@sixth = 1.0 / 6.0
		@first_sixth = 250
		@additional_sixth = 240
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
			@miles_driven = @miles_driven - @sixth
			fare = @first_sixth + @miles_driven * @additional_sixth
			fare.ceil
		end
	end
end
