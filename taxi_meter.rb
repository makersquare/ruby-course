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

  balance=0

  balance+=100 if Time.now.hour > 21 || Time.now.hour < 4
   

    if @start_time
      if @stop_time
          
        elsif dist == 0.1

          balance += 250

        elsif dist > 0.1  

          balance += ((dist*6).ceil*40+210)

            if @stop_time==nil

            wait_time = ((Time.now - @start_time)/60.0).ceil

            balance+= (wait_time*(2900/60.0)).round
           
          end

        elsif @airport==true && balance < 1310

          balance+=1310

          elsif @airport==true && balance > 1310

            balance += ((dist*6).ceil*40+210)

            if @stop_time==nil

            wait_time = ((Time.now - @start_time)/60.0).ceil

            balance+= (wait_time*(2900/60.0)).round

          end

        elsif @stop_time==nil


          wait_time = ((Time.now - @start_time)/60.0).ceil

          balance+= (wait_time*(2900/60.0)).round


            
      end 

    end
 
  end
       
end