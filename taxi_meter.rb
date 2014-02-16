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
  #binding.pry
  dist = @miles_driven
  cost = 0
  balance =0 
  if @start_time
  	if @stop_time
  			#elapsed_time=(@stop_time - @start_time) 
  			#2900/((@stop_time - @start_time) / 60)
	   		elsif dist == 0.1 #(1.0 / 6.0)
	  			250
	  		elsif dist >= (1.0 / 6.0) 	
	  			((dist*6).ceil*40+210) 
	  		elsif @airport==true && cost < 1310
	  			cost=1310	
	  		else
	  		0

	  	end
  	 end
end


  # if @start_time.to_i > 2100 && @stop_time.to_i < 0400


end
