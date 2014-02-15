class TaxiMeter

	attr_accessor :meter, :amount_due, :miles_driven
	attr_accessor :start_time, :stop_time, :mileage_cost
  
  def initialize(airport: false)
    @meter=meter
  	@amount_due=0
  	@miles_driven=0
  	@start_time=nil
  	@stop_time=nil
  	@airport=airport

  end

  def start
  	@start_time=Time.now
  end

  def stop
  	@stop_time=Time.now
  end

  def amount_due
  dist = @miles_driven
  cost = 0
  if @start_time
  	if @stop_time
  		time_elapsed = 2900/((@stop_time - @start_time) / 60)
   		elsif dist == (1.0 / 6.0)
  			250
  		elsif dist >= (1.0 / 6.0) 		
  			Time.now-@start_time + (cost+=(dist*6).ceil*40+210)
  		elsif @airport==true && cost < 1310
  			cost=1310
  		else
  		0
  	    end
  	 end
  end
end
