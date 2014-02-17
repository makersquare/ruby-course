require 'pry'

class TaxiMeter
  attr_accessor :miles_driven, :amount_due, :start_time, :stop_time
  
  def initialize(miles_driven:0,airport:false)
  	@miles_driven = miles_driven
  	@airport = airport
  	@start_time = nil
  	@stop_time = nil
  	
  end

  def start
  	 @start_time = Time.now
 
  end

  def stop
    unless @start_time != nil
  	 @stop_time = Time.now
    else
      @stop_time = false
      puts "You can't stop a ride you haven't started!"

    end
  end

  def amount_due
    @x = 0
    @sixths = (@miles_driven * 6).ceil

  	if @start_time != nil && stop_time == nil
  		@x += (((Time.now - @start_time)/60).ceil * 2900/60)
      if @start_time.hour >= 21 || @start_time.hour <= 4
        @x += 100
      end
    end

    if @stop_time != nil && start_time  != nil
      @x += (((@stop_time - @start_time)/60).ceil * 2900/60)
    end

    if @miles_driven > 0
      @x += 210
      @x += (@sixths * 40)
    end

	  if @airport && @x < 1310
		  @x += (1310-@x)
	  end

	  @x.round

  end

end
