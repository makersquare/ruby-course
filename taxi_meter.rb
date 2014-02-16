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
  balance = 0
  rolling_balance =0
  

  if @start_time
    if @stop_time
      elsif dist == 0.1
        balance += 250
        return balance
      elsif dist > 0.1  
        balance += ((dist*6).ceil*40+210)
        return balance
      elsif @airport==true && balance < 1310
        balance+=1310
        return balance
      else @stop_time==nil
      wait_time = ((Time.now - @start_time)/60).ceil
      if wait_time<60
      rolling_balance+= ((2900/60) * wait_time).ceil
      return rolling_balance
      else 
      rolling_balance+= ((2900.0/60.0) * wait_time).ceil
    end
      end  
   end
 end

  #  if @stop_time = nil
  #   balance+=rolling_balance
  # end
     #((dist*6).ceil*40+210)+
     # if @stop_time=nil





          #  else 
          # @stop_time == nil
          # cost +=(2900/((Time.now - @start_time)/60)) + ((dist*6).ceil*40+210)
          # return cost
end