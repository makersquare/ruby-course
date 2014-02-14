class TaxiMeter

	attr_accessor :meter, :amount_due, :miles_driven
	attr_accessor :start_time, :stop_time
  
  def initialize(airport: false)
    @meter=meter
  	@amount_due=0
  	@miles_driven=0
  	@start_time=nil
  	@stop_time=nil

  end

  def start
  	@start_time=Time.now
  end

  def stop
  	@stop_time=Time.now
  end

  def amount_due
  	if @miles_driven == (1.0 / 6.0)
  		@amount_due = 250
  	else
  		@amount_due = 250
  	end

  end

  	
end
